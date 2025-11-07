using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public abstract class Situation
{
    [Key]
    public Guid Id { get; set; }
    public string Title { get; set; } = "";
    public string Text { get; set; } = "";
    public string IllustrationUrl { get; set; } = "";
    public bool IsTerminal { get; set; } = false;
    public bool IsStarter { get; set; } = false;
    public List<Choice> Choices { get; set; } = new();
}