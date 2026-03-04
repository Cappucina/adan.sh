(() => {
    if (!('serviceWorker' in navigator)) return;

    // locate the sw relative to the current script (global-loader.js) to ensure
    //   it works regardless of the base path
    const swUrl = new URL('/sw.js', window.location.origin).href;

    navigator.serviceWorker.register(swUrl, { scope: '/' })
        .then((reg) => {
            window.addEventListener('focus', () => reg.update());
        })
        .catch(() => {
            // just silently fail
        });
})();
