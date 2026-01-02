using Microsoft.JSInterop;

namespace Game.Services;

public class SessionStorageService
{
    private readonly IJSRuntime _jsRuntime;
    private const string PlayerIdKey = "currentPlayerId";

    public SessionStorageService(IJSRuntime jsRuntime)
    {
        _jsRuntime = jsRuntime;
    }

    public async Task SetPlayerIdAsync(Guid playerId)
    {
        await _jsRuntime.InvokeVoidAsync("localStorage.setItem", PlayerIdKey, playerId.ToString());
    }

    public async Task<Guid?> GetPlayerIdAsync()
    {
        try
        {
            var value = await _jsRuntime.InvokeAsync<string>("localStorage.getItem", PlayerIdKey);
            if (string.IsNullOrEmpty(value))
                return null;

            return Guid.TryParse(value, out var playerId) ? playerId : null;
        }
        catch
        {
            return null;
        }
    }

    public async Task ClearPlayerIdAsync()
    {
        await _jsRuntime.InvokeVoidAsync("localStorage.removeItem", PlayerIdKey);
    }
}
