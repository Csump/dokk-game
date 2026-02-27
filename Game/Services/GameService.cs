using Game.Data;
using Game.Models;
using Microsoft.EntityFrameworkCore;

namespace Game.Services;

public class GameService(GameDbContext context, ILogger<GameService> logger)
{
    private readonly GameDbContext _context = context;
    private readonly ILogger<GameService> _logger = logger;

    public async Task<bool> IsUsernameAvailableAsync(string username)
    {
        try
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
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error checking username availability for: {Username}", username);
            return false;
        }
    }

    public async Task<(bool Success, Player? Player, string? ErrorMessage)> CreatePlayerAsync(
        string username, PlayerLevel level, Gender gender, Age age)
    {
        try
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
            return (true, player, null);
        }
        catch (DatabaseOperationException ex)
        {
            _logger.LogError(ex, "Database error creating player: {Username}", username);
            return (false, null, "Unable to create player due to database error. Please try again.");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unexpected error creating player: {Username}", username);
            return (false, null, "An unexpected error occurred. Please try again.");
        }
    }

    public async Task<Player?> GetPlayerAsync(int playerId)
    {
        try
        {
            return await _context.Players
                .Include(p => p.Decisions)
                .Include(p => p.Stats)
                .Include(p => p.Type)
                .FirstOrDefaultAsync(p => p.Id == playerId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving player: {PlayerId}", playerId);
            return null;
        }
    }

    public async Task<Situation?> GetCurrentSituationAsync(Player player)
    {
        try
        {
            return await _context.Situations
                .Include(s => s.Choices)
                .FirstOrDefaultAsync(s => s.Id == player.CurrentSituationId);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving situation for player: {PlayerId}", player.Id);
            return null;
        }
    }

    public async Task<(bool Success, Player Player, string? ErrorMessage)> ProceedAsync(Player player, int situationId)
    {
        try
        {
            var situation = await _context.Situations.FindAsync(situationId);
            if (situation == null)
            {
                return (false, player, "Situation not found.");
            }

            player.Proceed(situation);
            _context.Update(player);
            await _context.SaveChangesAsync();
            return (true, player, null);
        }
        catch (DatabaseOperationException ex)
        {
            _logger.LogError(ex, "Database error proceeding player {PlayerId} to situation {SituationId}", 
                player.Id, situationId);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "Unable to save progress. Please try again.");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unexpected error proceeding player {PlayerId}", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "An unexpected error occurred. Please try again.");
        }
    }

    public async Task<(bool Success, Player Player, string? ErrorMessage)> TakeChoiceAsync(Player player, int choiceId)
    {
        try
        {
            Choice? choice = await _context.Choices.FindAsync(choiceId);
            if (choice == null)
            {
                return (false, player, "Choice not found.");
            }

            Situation? situation = await _context.Situations.FindAsync(choice.SituationId);
            if (situation == null)
            {
                return (false, player, "Situation not found.");
            }

            player.TakeChoice(choice, situation);
            _context.Update(player);
            await _context.SaveChangesAsync();
            return (true, player, null);
        }
        catch (DatabaseOperationException ex)
        {
            _logger.LogError(ex, "Database error taking choice {ChoiceId} for player {PlayerId}", 
                choiceId, player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "Unable to save your choice. Please try again.");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unexpected error taking choice for player {PlayerId}", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "An unexpected error occurred. Please try again.");
        }
    }

    public async Task<(bool Success, Player Player, string? ErrorMessage)> ContinueFromHalftimeAsync(
        Player player, int nextSituationId)
    {
        try
        {
            player.CurrentSituationId = nextSituationId;
            _context.Update(player);
            await _context.SaveChangesAsync();
            return (true, player, null);
        }
        catch (DatabaseOperationException ex)
        {
            _logger.LogError(ex, "Database error continuing player {PlayerId} from halftime", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "Unable to continue. Please try again.");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unexpected error continuing player {PlayerId} from halftime", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "An unexpected error occurred. Please try again.");
        }
    }

    public async Task<(bool Success, string? ErrorMessage)> CompleteRunAsync(Player player)
    {
        try
        {
            player.CompletedAt = DateTime.UtcNow;
            _context.Update(player);
            await _context.SaveChangesAsync();
            return (true, null);
        }
        catch (DatabaseOperationException ex)
        {
            _logger.LogError(ex, "Database error completing run for player {PlayerId}", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, "Unable to complete run. Please try again.");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unexpected error completing run for player {PlayerId}", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, "An unexpected error occurred.");
        }
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

    public async Task<(bool Success, Player Player, string? ErrorMessage)> TakeMultipleChoicesAsync(
        Player player, IEnumerable<int> choiceIds)
    {
        try
        {
            var ids = choiceIds.ToList();
            var choices = await _context.Choices
                .Where(c => ids.Contains(c.Id))
                .ToListAsync();

            if (choices.Count != ids.Count)
            {
                return (false, player, "One or more choices not found.");
            }

            var situationId = choices.First().SituationId;
            if (choices.Any(c => c.SituationId != situationId))
            {
                return (false, player, "All choices must belong to the same situation.");
            }

            var situation = await _context.Situations.FindAsync(situationId);
            if (situation == null)
            {
                return (false, player, "Situation not found.");
            }

            if (situation.RequiredSelections.HasValue && choices.Count != situation.RequiredSelections.Value)
            {
                return (false, player, $"Exactly {situation.RequiredSelections} choices required.");
            }

            player.TakeMultipleChoices(choices, situation);
            _context.Update(player);
            await _context.SaveChangesAsync();
            return (true, player, null);
        }
        catch (DatabaseOperationException ex)
        {
            _logger.LogError(ex, "Database error taking multiple choices for player {PlayerId}", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "Unable to save your choices. Please try again.");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unexpected error taking multiple choices for player {PlayerId}", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "An unexpected error occurred. Please try again.");
        }
    }

    /// <summary>
    /// Loads minigame data for a Minigame situation: finds the player's multi-select choices
    /// from the most recent Special situation that precedes the current one, then loads their alignments.
    /// </summary>
    public async Task<List<(Choice Methodology, MethodologyAlignment Alignment)>> GetMinigameDataAsync(
        Player player)
    {
        // Find choice IDs the player has taken that belong to a Special situation
        var takenChoiceIds = player.Decisions.Select(d => d.ChoiceId).ToList();

        var specialChoices = await _context.Choices
            .Where(c => takenChoiceIds.Contains(c.Id))
            .Join(_context.Situations,
                c => c.SituationId,
                s => s.Id,
                (c, s) => new { Choice = c, Situation = s })
            .Where(x => x.Situation.Type == SituationType.Special)
            .Select(x => x.Choice)
            .ToListAsync();

        if (!specialChoices.Any())
            return new List<(Choice, MethodologyAlignment)>();

        var specialChoiceIds = specialChoices.Select(c => c.Id).ToList();
        var alignments = await _context.MethodologyAlignments
            .Where(a => specialChoiceIds.Contains(a.ChoiceId))
            .ToListAsync();

        return specialChoices
            .Join(alignments, c => c.Id, a => a.ChoiceId, (c, a) => (c, a))
            .ToList();
    }

    public async Task<(bool Success, Player Player, string? ErrorMessage)> ApplyMinigameDeltaAsync(
        Player player, Stats delta)
    {
        try
        {
            player.ApplyDelta(delta);
            _context.Update(player);
            await _context.SaveChangesAsync();
            return (true, player, null);
        }
        catch (DatabaseOperationException ex)
        {
            _logger.LogError(ex, "Database error applying minigame delta for player {PlayerId}", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "Unable to save progress. Please try again.");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unexpected error applying minigame delta for player {PlayerId}", player.Id);
            _context.Entry(player).State = EntityState.Unchanged;
            return (false, player, "An unexpected error occurred. Please try again.");
        }
    }
}