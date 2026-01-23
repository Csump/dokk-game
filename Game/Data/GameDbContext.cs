using Game.Models;
using Microsoft.EntityFrameworkCore;

namespace Game.Data;

public class GameDbContext : DbContext
{
    public GameDbContext(DbContextOptions<GameDbContext> options) : base(options) { }

    public DbSet<Player> Players => Set<Player>();
    public DbSet<Situation> Situations => Set<Situation>();
    public DbSet<Choice> Choices => Set<Choice>();
    public DbSet<DecisionLog> Decisions => Set<DecisionLog>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Player table mapping
        modelBuilder.Entity<Player>(entity =>
        {
            entity.ToTable("players");
            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Username).HasColumnName("name");
            entity.Property(e => e.CurrentSituationId).HasColumnName("current_situation_id");
            entity.Property(e => e.CreatedAt).HasColumnName("created_at").HasDefaultValueSql("CURRENT_TIMESTAMP");
            entity.Property(e => e.CompletedAt).HasColumnName("completed_at");

            entity.OwnsOne(p => p.Type, type =>
            {
                type.Property(t => t.Gender)
                    .HasColumnName("is_male")
                    .HasConversion(
                        g => g == Gender.Male,
                        b => b ? Gender.Male : Gender.Female);

                type.Property(t => t.Age)
                    .HasColumnName("is_old")
                    .HasConversion(
                        a => a == Age.Old,
                        b => b ? Age.Old : Age.Young);

                type.Property(t => t.Level)
                    .HasColumnName("level")
                    .HasConversion<int>();
            });

            entity.OwnsOne(p => p.Stats, stats =>
            {
                stats.Property(s => s.Energy).HasColumnName("energy").HasDefaultValue(0);
                stats.Property(s => s.SelfReflection).HasColumnName("selfreflection").HasDefaultValue(0);
                stats.Property(s => s.Competency).HasColumnName("competency").HasDefaultValue(0);
                stats.Property(s => s.Initiative).HasColumnName("initiative").HasDefaultValue(0);
                stats.Property(s => s.Creativity).HasColumnName("creativity").HasDefaultValue(0);
                stats.Property(s => s.Cooperation).HasColumnName("cooperation").HasDefaultValue(0);
                stats.Property(s => s.Success).HasColumnName("motivation").HasDefaultValue(0);
            });
        });

        // DecisionLog table mapping
        modelBuilder.Entity<DecisionLog>(entity =>
        {
            entity.ToTable("decisions");
            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.PlayerId).HasColumnName("player_id");
            entity.Property(e => e.ChoiceId).HasColumnName("choice_id");
            entity.Property(e => e.TakenAt).HasColumnName("timestamp");

            entity.HasOne<Player>()
                .WithMany(p => p.Decisions)
                .HasForeignKey(d => d.PlayerId);
        });

        // Situation table mapping
        modelBuilder.Entity<Situation>(entity =>
        {
            entity.ToTable("situations");
            entity.Property(e => e.Id).HasColumnName("id").ValueGeneratedNever(); // Important: don't auto-generate
            entity.Property(e => e.Title).HasColumnName("title");
            entity.Property(e => e.Text).HasColumnName("situation_text");
            entity.Property(e => e.IllustrationUrl).HasColumnName("illustration");
            entity.Property(e => e.IsStarter).HasColumnName("is_starter");
            entity.Property(e => e.IsHalftime).HasColumnName("is_halftime");
            entity.Property(e => e.IsTerminal).HasColumnName("is_terminal");
            entity.Property(e => e.NextSituationId).HasColumnName("next_situation_id");
            entity.Property(e => e.Type)
                .HasColumnName("situation_type")
                .HasConversion<int>();
        });

        // Choice table mapping
        modelBuilder.Entity<Choice>(entity =>
        {
            entity.ToTable("choices");
            entity.Property(e => e.Id).HasColumnName("id").ValueGeneratedNever(); // Important: don't auto-generate
            entity.Property(e => e.SituationId).HasColumnName("situation_id");
            entity.Property(e => e.Text).HasColumnName("choice_text");
            entity.Property(e => e.NextSituationId).HasColumnName("next_situation_id");

            entity.OwnsOne(c => c.DeltaStats, stats =>
            {
                stats.Property(s => s.Energy).HasColumnName("delta_energy");
                stats.Property(s => s.SelfReflection).HasColumnName("delta_selfreflection");
                stats.Property(s => s.Competency).HasColumnName("delta_competency");
                stats.Property(s => s.Initiative).HasColumnName("delta_initiative");
                stats.Property(s => s.Creativity).HasColumnName("delta_creativity");
                stats.Property(s => s.Cooperation).HasColumnName("delta_cooperation");
                stats.Property(s => s.Success).HasColumnName("delta_motivation");
            });
        });
    }
}