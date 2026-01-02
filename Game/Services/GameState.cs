using Game.Models;

namespace Game.Services;

public class GameState
{
    private readonly SessionStorageService? _sessionStorage;
    private readonly GameService? _gameService;

    public Player? CurrentPlayer { get; private set; }
    public event Action? Changed;

    public bool HasActiveSession => CurrentPlayer != null;

    public GameState(SessionStorageService sessionStorage, GameService gameService)
    {
        _sessionStorage = sessionStorage;
        _gameService = gameService;
    }

    public async Task SetPlayerAsync(Player player)
    {
        CurrentPlayer = player;
        if (_sessionStorage != null)
        {
            await _sessionStorage.SetPlayerIdAsync(player.Id);
            await Task.Delay(50);
        }
        NotifyChanged();
    }

    public async Task UpdatePlayerAsync(Player player)
    {
        if (CurrentPlayer?.Id == player.Id)
        {
            CurrentPlayer = player;
            if (_sessionStorage != null)
            {
                await _sessionStorage.SetPlayerIdAsync(player.Id);
            }
            NotifyChanged();
        }
    }

    public async Task<bool> RestorePlayerAsync()
    {
        if (_sessionStorage == null || _gameService == null)
            return false;

        var playerId = await _sessionStorage.GetPlayerIdAsync();
        if (playerId == null)
            return false;

        var player = await _gameService.GetPlayerAsync(playerId.Value);
        if (player == null)
        {
            await ClearAsync();
            return false;
        }

        CurrentPlayer = player;
        NotifyChanged();
        return true;
    }

    public async Task ClearAsync()
    {
        CurrentPlayer = null;
        if (_sessionStorage != null)
        {
            await _sessionStorage.ClearPlayerIdAsync();
        }
        NotifyChanged();
    }

    private void NotifyChanged() => Changed?.Invoke();
}

