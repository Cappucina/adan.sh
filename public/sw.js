const CACHE_NAME = 'adan-assets-v1';

// client-side asset caching for loading performance

// service workers registered in global-loader.js to ensure
//   they are registered as early as possible, but after the
//   loader is shown to avoid delaying the first paint with
//   SW registration work

const PRECACHE_ASSETS = [
    '/assets/logo.png',
];

self.addEventListener('install', (e) => {
    e.waitUntil(
        caches.open(CACHE_NAME).then((cache) => cache.addAll(PRECACHE_ASSETS))
    );
    self.skipWaiting();
});

self.addEventListener('activate', (e) => {
    e.waitUntil(
        caches.keys().then((keys) =>
            Promise.all(
                keys
                    .filter((key) => key !== CACHE_NAME)
                    .map((key) => caches.delete(key))
            )
        )
    );
    self.clients.claim();
});

self.addEventListener('fetch', (e) => {
    const { request } = e;

    if (request.method !== 'GET') return;

    const url = new URL(request.url);

    const isAsset = /\.(png|jpg|jpeg|svg|gif|webp|ico|woff2?|ttf|otf)$/i.test(url.pathname);
    const isStyle = /\.css$/i.test(url.pathname);
    const isScript = /\.js$/i.test(url.pathname);
    const isCDN = url.hostname !== self.location.hostname;

    if (isAsset || isStyle || isScript || isCDN) {
        e.respondWith(
            caches.open(CACHE_NAME).then(async (cache) => {
                const cached = await cache.match(request);
                const networkFetch = fetch(request).then((response) => {
                    if (response.ok) {
                        cache.put(request, response.clone());
                    }
                    return response;
                }).catch(() => cached);

                return cached || networkFetch;
            })
        );
    }
});
