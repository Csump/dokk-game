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
        modelBuilder.Entity<Player>().OwnsOne(p => p.Type);
        modelBuilder.Entity<Player>().OwnsOne(c => c.Stats);
        modelBuilder.Entity<Choice>().OwnsOne(c => c.DeltaStats);
    }

}