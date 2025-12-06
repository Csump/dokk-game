namespace Game.Models;

public class Stats
{
    private const int MAX_LEVEL = 100;
    private const int MIN_LEVEL = 0;

    public int Energy { get; private set; }
    public int Success { get; private set; }
    public int SelfReflection { get; private set; }
    public int Creativity { get; private set; }
    public int Cooperation { get; private set; }
    public int Competency { get; private set; }
    public int Initiative { get; private set; }

    public Stats(int energy = 50, int success = 50, int selfreflection = 50,
        int creativity = 50, int cooperation = 50,
        int competency = 50, int initiative = 50)
    {
        Energy = energy;
        Success = success;
        SelfReflection = selfreflection;
        Creativity = creativity;
        Cooperation = cooperation;
        Competency = competency;
        Initiative = initiative;
    }

    public Stats() { }
    
    public static Stats GetDefault(Level level, Gender gender, Age age)
    {
        int baseVal = level switch
        {
            Level.Doktorandusz => 40,
            Level.Docens => 55,
            Level.Adjunktus => 65,
            _ => 50
        };

        return new Stats(baseVal, baseVal, baseVal, baseVal, baseVal, baseVal, baseVal);
    }

    public void ApplyDelta(Stats delta)
    {
        Energy = Clamp(Energy + delta.Energy);
        Success = Clamp(Success + delta.Success);
        SelfReflection = Clamp(SelfReflection + delta.SelfReflection);
        Creativity = Clamp(Creativity + delta.Creativity);
        Cooperation = Clamp(Cooperation + delta.Cooperation);
        Competency = Clamp(Competency + delta.Competency);
        Initiative = Clamp(Initiative + delta.Initiative);
    }

    public int Total => Energy + Success + SelfReflection + Creativity + Cooperation + Competency + Initiative;

    public IReadOnlyDictionary<string, (string Canonical, int Value)> AsDictionary() => new Dictionary<string, (string, int)>
    {
        ["Energia"] = ("Energy", Energy),
        ["Hallgatói motiváció"] = ("Success", Success),
        ["Önreflexió"] = ("SelfReflection", SelfReflection),
        ["Kreativitás"] = ("Creativity", Creativity),
        ["Együttműködés"] = ("Cooperation", Cooperation),
        ["Felkészültség"] = ("Competency", Competency),
        ["Kezdeményezőkészség"] = ("Initiative", Initiative)
    };

    private int Clamp(int value) => Math.Clamp(value, MIN_LEVEL, MAX_LEVEL);
}