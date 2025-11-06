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

    public async Task<Player> CreatePlayerAsync(string username, Level level, Gender gender, Age age)
    {
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

    public async Task<Situation?> GetCurrentSituationAsync(Player player)
    {
        return await _context.Situations
            .Include(s => s.Choices)
            .FirstOrDefaultAsync(s => s.Id == player.CurrentSituationId);
    }

    public async Task<Player> TakeChoiceAsync(Player player, int choiceId)
    {
        var choice = await _context.Choices.FindAsync(choiceId);
        if (choice == null) return player;

        player.TakeChoice(choice);
        _context.Update(player);
        await _context.SaveChangesAsync();
        return player;
    }
}