namespace Game.Models;

public class Stats
{
    private const int MAX_LEVEL = 100;
    private const int MIN_LEVEL = 0;

    public int Energy { get; private set; }
    public int Motivation { get; private set; }
    public int Confidence { get; private set; }
    public int Proactivity { get; private set; }
    public int Cooperation { get; private set; }
    public int Preparedness { get; private set; }
    public int Creativity { get; private set; }

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
        int baseVal = level switch
        {
            Level.Student => 40,
            Level.Graduate => 55,
            Level.Professional => 65,
            Level.Doctor => 70,
            Level.Professor => 75,
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

    public int Total => Energy + Motivation + Confidence + Proactivity + Cooperation + Preparedness + Creativity;

    public IReadOnlyDictionary<string, int> AsDictionary() => new Dictionary<string, int>
    {
        ["Energy"] = Energy,
        ["Motivation"] = Motivation,
        ["Confidence"] = Confidence,
        ["Proactivity"] = Proactivity,
        ["Cooperation"] = Cooperation,
        ["Preparedness"] = Preparedness,
        ["Creativity"] = Creativity
    };

    private int Clamp(int value) => Math.Clamp(value, MIN_LEVEL, MAX_LEVEL);
}