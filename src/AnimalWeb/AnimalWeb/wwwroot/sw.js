console.log('sw.js loaded');
const mainCacheName = 'sonyasapp-01';
self.addEventListener('install', async event => {
    event.waitUntil(self.skipWaiting());
});
self.addEventListener('activate', function (event) {
    event.waitUntil(self.clients.claim()); // Become available to all pages
});

self.addEventListener('fetch', async event => {
    handleFetch(event);
});

async function handleFetch(event) {
    const url = new URL(event.request.url);
    
    if (event.request.method === 'GET'){
        var respondWithCacheFirst = true;

        // TODO: If the url has a thumbprint do cache first

        if(event.request.destination == "image"){
            event.respondWith(cacheFirst(event.request));
        }
        else{
            event.respondWith(networkFirst(event.request));
        }
    }
    else {
        // let the browser do the default action
        return;
    }
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
    
    if(response.status === 200){
        cache.put(request, response.clone());
    }

    return response;
}

async function networkFirst(request) {
    console.log('networkFirst');
    const cache = await caches.open(mainCacheName);

    try {
        const response = await fetch(request);
        if(response.status === 200){
            cache.put(request, response.clone());
        }
        return response;
    }
    catch (error) {
        return cache.match(request);
    }
}

self.addEventListener('message', async function (event) {
    console.log("SW Received Message: " + event.data);
    UpdateApp();
});

async function UpdateApp() {
    const cache = await caches.open(mainCacheName);

    try {
        caches.delete(mainCacheName);
    }
    catch (error) {
        console.log('error: ' + error);
    }
    console.log('removed assets');
}