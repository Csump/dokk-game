using Game.Data;
using Game.Models;

namespace Game.Services;

public static class SeedData
{
    public static void Initialize(GameDbContext context)
    {
        if (context.Situations.Any()) return;

        var s1 = new Decision { Id = Guid.NewGuid(), Title = "The Beginning", Text = "Your adventure starts!", IsStarter = true, IllustrationUrl = "images/start.png"};
        var s2 = new Info { Id = Guid.NewGuid(), Title = "The Crossroad", Text = "You see two paths ahead.", IllustrationUrl = "images/crossroad.png" };
        var s3 = new Conversation { Id = Guid.NewGuid(), Title = "Victory!", Text = "You’ve reached the end.", IsTerminal = true, IllustrationUrl = "images/victory.png" };

        var c1 = new Choice
        {
            Id = Guid.NewGuid(),
            SituationId = s1.Id,
            Text = "Walk forward",
            NextSituationId = s2.Id,
            DeltaStats = new Stats(energy: -5, success: +5)
        };

        var c2 = new Choice
        {
            Id = Guid.NewGuid(),
            SituationId = s2.Id,
            Text = "Take the left path",
            NextSituationId = s3.Id,
            DeltaStats = new Stats(energy: -10, selfreflection: +10)
        };

        s1.Choices.Add(c1);
        s2.Choices.Add(c2);

        context.Situations.AddRange(s1, s2, s3);
        context.Choices.AddRange(c1, c2);
        context.SaveChanges();
    }
}