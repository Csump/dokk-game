using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public class Player
{
    [Key]
    public int Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public Stats Stats { get; set; } = new();
    public PlayerType Type { get; set; } = new();
    public List<DecisionLog> Decisions { get; set; } = new();
    public int CurrentSituationId { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? CompletedAt { get; set; }

    public int TotalScore => Stats.Total;

    public void TakeChoice(Choice choice, Situation situation)
    {
        Stats.ApplyDelta(choice.DeltaStats);
        Decisions.Add(new DecisionLog { ChoiceId = choice.Id });

        if (situation.IsTerminal)
        {
            CompletedAt = DateTime.UtcNow;
            return;
        }

        if (!situation.IsHalftime)
        {
            CurrentSituationId = choice.NextSituationId;
        }
    }

    public void Proceed(Situation situation)
    {
        if (situation.IsTerminal)
        {
            CompletedAt = DateTime.UtcNow;
            return;
        }

        if (!situation.IsHalftime)
        {
            CurrentSituationId = situation.NextSituationId ?? CurrentSituationId;
        }
    }
}