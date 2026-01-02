using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public class Choice
{
    [Key]
    public Guid Id { get; set; }
    public string ExternalId { get; set; } = default!;
    public Guid SituationId { get; set; }
    public string SituationExternalId { get; set; } = default!;
    public string Text { get; set; } = default!;
    public Guid NextSituationId { get; set; }
    public string NextSituationExternalId { get; set; } = default!;
    public Stats DeltaStats { get; set; } = new();
}