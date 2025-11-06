using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public class Choice
{
    [Key]
    public Guid Id { get; set; }
    public Guid SituationId { get; set; }
    public string Text { get; set; } = "";
    public string Description { get; set; } = "";
    public Guid NextSituationId { get; set; }
    public Stats DeltaStats { get; set; } = new();

    public void ApplyChoice(Player player) => player.TakeChoice(this);
}