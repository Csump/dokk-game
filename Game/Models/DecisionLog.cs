using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public class DecisionLog
{
    [Key]
    public Guid Id { get; set; }
    public Guid ChoiceId { get; set; }
    public DateTime TakenAt { get; set; } = DateTime.Now;
}