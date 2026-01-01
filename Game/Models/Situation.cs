using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public abstract class Situation
{
    [Key]
    public Guid Id { get; set; }
    public string ExternalId { get; set; } = default!;
    public Guid? NextSituationId { get; set; }
    public string NextSituationExternalId { get; set; } = default!;
    public string Title { get; set; } = default!;
    public string Text { get; set; } = default!;
    public string IllustrationUrl { get; set; } = default!;
    public bool IsTerminal { get; set; } = false;
    public bool IsHalftime { get; set; } = false;
    public bool IsStarter { get; set; } = false;
    public List<Choice> Choices { get; set; } = new();
}