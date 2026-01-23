using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public class Choice
{
    [Key]
    public int Id { get; set; }
    public int SituationId { get; set; }
    public string Text { get; set; } = default!;
    public int NextSituationId { get; set; }
    public Stats DeltaStats { get; set; } = new();
}