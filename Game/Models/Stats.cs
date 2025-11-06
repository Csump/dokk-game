namespace Game.Models;

public class Stats
{
    private const int MAX_LEVEL = 100;
    private const int MIN_LEVEL = 0;
    private int Energy { get; set; }
    private int Motivation { get; set; }
    private int Confidence { get; set; }
    private int Proactivity { get; set; }
    private int Cooperation { get; set; }
    private int Preparedness { get; set; }
    private int Creativity { get; set; }

    public Stats(int energy = 50, int motivation = 50, int confidence = 50,
        int proactivity = 50, int cooperation = 50,
        int preparedness = 50, int creativity = 50)
    {
        Energy = energy;
        Motivation = motivation;
        Confidence = confidence;
        Proactivity = proactivity;
        Cooperation = cooperation;
        Preparedness = preparedness;
        Creativity = creativity;
    }

    public Stats() { }
    
    public static Stats GetDefault(Level level, Gender gender, Age age)
    {
        // TODO adjust
        int baseVal = level switch
        {
            Level.Junior => 40,
            Level.Medior => 60,
            Level.Senior => 70,
            _ => 50
        };

        return new Stats(baseVal, baseVal, baseVal, baseVal, baseVal, baseVal, baseVal);
    }

    public void ApplyDelta(Stats delta)
    {
        Energy = Clamp(Energy + delta.Energy);
        Motivation = Clamp(Motivation + delta.Motivation);
        Confidence = Clamp(Confidence + delta.Confidence);
        Proactivity = Clamp(Proactivity + delta.Proactivity);
        Cooperation = Clamp(Cooperation + delta.Cooperation);
        Preparedness = Clamp(Preparedness + delta.Preparedness);
        Creativity = Clamp(Creativity + delta.Creativity);
    }

    private int Clamp(int value) => Math.Clamp(value, MIN_LEVEL, MAX_LEVEL);
}