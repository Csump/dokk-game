using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public class MethodologyAlignment
{
    [Key]
    public int Id { get; set; }
    public int ChoiceId { get; set; }
    public string AimText { get; set; } = default!;
    public string AssessmentText { get; set; } = default!;
    public Stats CorrectDelta { get; set; } = new();
    public Stats IncorrectDelta { get; set; } = new();
}
