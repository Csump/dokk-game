using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public class DecisionLog
{
    [Key]
    public int Id { get; set; }
    public int PlayerId { get; set; }
    public int ChoiceId { get; set; }
    public DateTime TakenAt { get; set; } = DateTime.Now;
}