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

    public static Stats GetDefault(PlayerLevel level, Gender gender, Age age)
    {
        switch (gender, age)
        {
            // Zsófia
            case (Gender.Female, Age.Young):
                return new Stats(48, 0, 5, 5, 3, 4, 3);

            // Gabriella
            case (Gender.Female, Age.Old):
                return new Stats(46, 0, 3, 5, 4, 5, 3);

            // Máté
            case (Gender.Male, Age.Young):
                return new Stats(50, 0, 4, 3, 5, 3, 5);

            // Iván
            case (Gender.Male, Age.Old):
                return new Stats(44, 0, 5, 3, 3, 5, 4);

            default:
                int baseVal = 5;
                return new Stats(baseVal, baseVal, baseVal, baseVal, baseVal, baseVal, baseVal);
        }
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

    public int Total => Energy + Success;

    public IReadOnlyDictionary<string, (string Canonical, int Value, StatType Type)> AsDictionary() => new Dictionary<string, (string, int, StatType)>
    {
        ["Energia"] = ("Energy", Energy, StatType.Energy),
        ["Hallgatói motiváció"] = ("Success", Success, StatType.Success),
        ["Önreflexió"] = ("SelfReflection", SelfReflection, StatType.SelfReflection),
        ["Kreativitás"] = ("Creativity", Creativity, StatType.Creativity),
        ["Együttműködés"] = ("Cooperation", Cooperation, StatType.Cooperation),
        ["Felkészültség"] = ("Competency", Competency, StatType.Competency),
        ["Kezdeményezőkészség"] = ("Initiative", Initiative, StatType.Initiative)
    };

    private int Clamp(int value) => Math.Clamp(value, MIN_LEVEL, MAX_LEVEL);
}