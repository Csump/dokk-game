using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace Game.Models;

public class Player
{
    [Key]
    public Guid Id { get; set; }
    public string Username { get; set; } = string.Empty;
    public Stats Stats { get; set; } = new();
    public PlayerType Type { get; set; } = new();
    public List<DecisionLog> Decisions { get; set; } = new();
    public Guid CurrentSituationId { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? CompletedAt { get; set; }

    public int TotalScore => Stats.Total;

    public void TakeChoice(Choice choice)
    {
        Stats.ApplyDelta(choice.DeltaStats);
        Decisions.Add(new DecisionLog { ChoiceId = choice.Id });
        CurrentSituationId = choice.NextSituationId;
    }

    public void Proceed(Situation situation)
    {
        CurrentSituationId = situation.NextSituationId ?? CurrentSituationId;
    }
}