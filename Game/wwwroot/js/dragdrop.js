// Allow dropping on .alignment-slot elements by synchronously preventing the
// browser default "no-drop" behavior. This must run in JS (not via Blazor
// Server's SignalR round-trip) because preventDefault() must be called
// synchronously during the dragover event.
(function () {
    document.addEventListener('dragover', function (e) {
        if (e.target && e.target.closest && e.target.closest('.alignment-slot')) {
            e.preventDefault();
        }
    }, false);
})();
