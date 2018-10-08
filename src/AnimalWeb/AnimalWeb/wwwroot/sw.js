const mainCacheName = 'sonyasapp-01';
self.addEventListener('activate', function (event) {
    event.waitUntil(self.clients.claim()); // Become available to all pages
});

self.addEventListener('fetch', async event => {
    handleFetch(event);
});

async function handleFetch(event) {
    const url = new URL(event.request.url);

    var respondWithCacheFirst = true;

    if(url.pathname.endsWith('.css') || url.pathname.endsWith('.js') || url.pathname === "/"){
        respondWithCacheFirst = false;
    }

    respondWithCacheFirst ? 
        event.respondWith(cacheFirst(event.request)) : 
        event.respondWith(networkFirst(event.request));

}

async function cacheFirst(request) {
    try {
        const cachedResponse = await caches.match(request);
        if (cachedResponse) {
            return cachedResponse
        }
    }
    catch (error) {
        console.debug('error in cacheFirst():'+error);
    }

    var response = await fetch(request);
    const cache = await caches.open(mainCacheName);
    cache.put(request, response.clone());

    return response;
}

async function networkFirst(request) {
    console.log('networkFirst');
    const cache = await caches.open(mainCacheName);

    try {
        const response = await fetch(request);
        cache.put(request, response.clone());
        return response;
    }
    catch (error) {
        return cache.match(request);
    }
}

