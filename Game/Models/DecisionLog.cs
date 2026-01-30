using System.ComponentModel.DataAnnotations;

namespace Game.Models;

public class DecisionLog
{
    [Key]
    public int Id { get; set; }
    public int PlayerId { get; set; }
    public int ChoiceId { get; set; }
    private DateTime _takenAt = DateTime.UtcNow;
    
    public DateTime TakenAt 
    { 
        get => _takenAt;
        set => _takenAt = value.Kind == DateTimeKind.Utc 
            ? value 
            : DateTime.SpecifyKind(value, DateTimeKind.Utc);
    }
}