using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public class Situation
{
    [Key]
    public int Id { get; set; }
    public string? Title { get; set; }
    public string? Text { get; set; }
    public string? IllustrationUrl { get; set; }
    public bool IsStarter { get; set; } = false;
    public bool IsHalftime { get; set; } = false;
    public bool IsTerminal { get; set; } = false;
    public int? NextSituationId { get; set; }
    public List<Choice> Choices { get; set; } = new();
    public SituationType Type { get; }
}