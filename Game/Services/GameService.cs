using Game.Data;
using Game.Models;
using Microsoft.EntityFrameworkCore;

namespace Game.Services;

public class GameService
{
    private readonly GameDbContext _context;

    public GameService(GameDbContext context)
    {
        _context = context;
    }

    public async Task<bool> IsUsernameAvailableAsync(string username)
    {
        if (string.IsNullOrWhiteSpace(username))
        {
            return false;
        }

        var normalized = username.Trim().ToLower();

        return !await _context.Players
            .AnyAsync(p => p.Username != null &&
                           p.Username.Trim().ToLower() == normalized);
    }

    public async Task<Player> CreatePlayerAsync(string username, PlayerLevel level, Gender gender, Age age)
    {
        username = username?.Trim() ?? string.Empty;

        var player = new Player
        {
            Username = username,
            Type = new PlayerType { Level = level, Gender = gender, Age = age },
            Stats = Stats.GetDefault(level, gender, age),
            CurrentSituationId = _context.Situations.First(s => s.IsStarter).Id
        };

        _context.Players.Add(player);
        await _context.SaveChangesAsync();
        return player;
    }

    public async Task<Player?> GetPlayerAsync(int playerId)
    {
        return await _context.Players
            .Include(p => p.Decisions)
            .Include(p => p.Stats)
            .Include(p => p.Type)
            .FirstOrDefaultAsync(p => p.Id == playerId);
    }

    public async Task<Situation?> GetCurrentSituationAsync(Player player)
    {
        return await _context.Situations
            .Include(s => s.Choices)
            .FirstOrDefaultAsync(s => s.Id == player.CurrentSituationId);
    }

    public async Task<Player> ProceedAsync(Player player, int situationId)
    {
        var situation = await _context.Situations.FindAsync(situationId);
        if (situation == null) return player;

        player.Proceed(situation);
        _context.Update(player);
        await _context.SaveChangesAsync();
        return player;
    }

    public async Task<Player> TakeChoiceAsync(Player player, int choiceId)
    {
        Choice? choice = await _context.Choices.FindAsync(choiceId);
        if (choice == null) return player;

        Situation? situation = await _context.Situations.FindAsync(choice.SituationId);
        if (situation == null) return player;

        player.TakeChoice(choice, situation);
        _context.Update(player);
        await _context.SaveChangesAsync();
        return player;
    }

    public async Task<Player> ContinueFromHalftimeAsync(Player player, int nextSituationId)
    {
        player.CurrentSituationId = nextSituationId;
        _context.Update(player);
        await _context.SaveChangesAsync();
        return player;
    }

    public async Task CompleteRunAsync(Player player)
    {
        player.CompletedAt = DateTime.UtcNow;
        _context.Update(player);
        await _context.SaveChangesAsync();
    }

    public async Task<List<Player>> GetLeaderboardAsync()
    {
        var completedRuns = await _context.Players
            .Where(p => !string.IsNullOrWhiteSpace(p.Username) && p.CompletedAt != null)
            .Include(p => p.Decisions)
            .ToListAsync();

        return completedRuns
            .GroupBy(p => p.Username!, StringComparer.OrdinalIgnoreCase)
            .Select(group => group.OrderByDescending(p => p.CompletedAt).First())
            .OrderByDescending(p => p.TotalScore)
            .ThenByDescending(p => p.CompletedAt)
            .ToList();
    }
}