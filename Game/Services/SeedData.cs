using Game.Data;
using Game.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualBasic.FileIO;

namespace Game.Services;

public static class SeedData
{
    public static void Initialize(GameDbContext context, IWebHostEnvironment env)
    {
        if (context.Situations.Any())
            return;

        var basePath = Path.Combine(env.ContentRootPath, "Data");

        var situations = LoadSituations(Path.Combine(basePath, "situations.csv"));
        var choices = LoadChoices(Path.Combine(basePath, "choices.csv"));

        var situationMap = situations.ToDictionary(s => s.ExternalId, s => s);

        foreach (var situation in situations)
        {
            if (!string.IsNullOrEmpty(situation.NextSituationExternalId) && 
                situationMap.TryGetValue(situation.NextSituationExternalId, out var nextSituation))
            {
                situation.NextSituationId = nextSituation.Id;
            }
        }

        foreach (var choice in choices)
        {
            choice.SituationId = situationMap[choice.SituationExternalId].Id;
            choice.NextSituationId = situationMap[choice.NextSituationExternalId].Id;

            situationMap[choice.SituationExternalId].Choices.Add(choice);
        }

        context.Situations.AddRange(situations);
        context.Choices.AddRange(choices);
        context.SaveChanges();
    }

    private static List<Situation> LoadSituations(string path)
    {
        var result = new List<Situation>();

        using var parser = new TextFieldParser(path);
        parser.SetDelimiters(";");
        parser.HasFieldsEnclosedInQuotes = true;

        parser.ReadLine();

        while (!parser.EndOfData)
        {
            var c = parser.ReadFields();
            if (c == null) continue;

            var type = c[7];
            Situation s = type switch
            {
                "Döntés" => new Decision(),
                "Spéci" => new Decision(),
                "Infó" => new Info(),
                "Minijáték" => new Info(),
                "Párbeszéd" => new Conversation(),
                _ => throw new Exception($"Unknown situation type: {type}")
            };

            s.Id = Guid.NewGuid();
            s.ExternalId = c[0];
            s.Title = c[1];
            s.Text = c[2];
            s.IllustrationUrl = c[3];
            s.IsStarter = bool.Parse(c[4]);
            s.IsHalftime = bool.Parse(c[5]);
            s.IsTerminal = bool.Parse(c[6]);
            s.NextSituationExternalId = c[8];

            result.Add(s);
        }

        return result;
    }

    private static List<Choice> LoadChoices(string path)
    {
        var result = new List<Choice>();

        using var parser = new TextFieldParser(path);
        parser.SetDelimiters(";");
        parser.HasFieldsEnclosedInQuotes = true;

        parser.ReadLine();

        while (!parser.EndOfData)
        {
            var c = parser.ReadFields();
            if (c == null) continue;

            var choice = new Choice
            {
                Id = Guid.NewGuid(),
                ExternalId = c[0],
                SituationExternalId = c[1],
                Text = c[2],
                NextSituationExternalId = c[3],
                DeltaStats = new Stats(
                    energy: ParseIntOrZero(c[4]),
                    selfreflection: ParseIntOrZero(c[5]),
                    competency: ParseIntOrZero(c[6]),
                    initiative: ParseIntOrZero(c[7]),
                    creativity: ParseIntOrZero(c[8]),
                    cooperation: ParseIntOrZero(c[9]),
                    success: ParseIntOrZero(c[10])
                )
            };

            result.Add(choice);
        }

        return result;
    }

    private static int ParseIntOrZero(string s) =>
        int.TryParse(s, out var result) ? result : 0;
}
