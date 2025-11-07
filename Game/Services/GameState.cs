using Game.Models;

namespace Game.Services;

public class GameState
{
    public Player? CurrentPlayer { get; private set; }
    public event Action? Changed;

    public bool HasActiveSession => CurrentPlayer != null;

    public void SetPlayer(Player player)
    {
        CurrentPlayer = player;
        NotifyChanged();
    }

    public void UpdatePlayer(Player player)
    {
        if (CurrentPlayer?.Id == player.Id)
        {
            CurrentPlayer = player;
            NotifyChanged();
        }
    }

    public void Clear()
    {
        CurrentPlayer = null;
        NotifyChanged();
    }

    private void NotifyChanged() => Changed?.Invoke();
}

