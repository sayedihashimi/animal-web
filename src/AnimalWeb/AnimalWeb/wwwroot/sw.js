const mainCacheName = 'sonyasapp-01';

const mp3Files = [
    "/media/alligator.mp3",
    "/media/alpaca.mp3",
    "/media/baboon.mp3",
    "/media/bat.mp3",
    "/media/Bee buzzing animals131.mp3",
    "/media/Bird chirps animals140.mp3",
    "/media/brown-bear.mp3",
    "/media/camel.mp3",
    "/media/Capuchin monkey animals075.mp3",
    "/media/Cat meow animals021.mp3",
    "/media/chicken.mp3",
    "/media/chimp.mp3",
    "/media/chipmunk.mp3",
    "/media/Cow animals055.mp3",
    "/media/Crow caw animals063.mp3",
    "/media/Dog animals080.mp3",
    "/media/donkey.mp3",
    "/media/Duck-quacking animals038.mp3",
    "/media/Elephant-angry animals035.mp3",
    "/media/frog.mp3",
    "/media/Geese (Canadian)-flockanimals003.mp3",
    "/media/giraffe.mp3",
    "/media/goat.mp3",
    "/media/Gorilla growl animals028.mp3",
    "/media/Hawk animals083.mp3",
    "/media/hippo.mp3",
    "/media/Horse whinny animals126.mp3",
    "/media/hyena.mp3",
    "/media/Leopard growl animals089.mp3",
    "/media/Lion roar animals031.mp3",
    "/media/lion-01.mp3",
    "/media/mouse.mp3",
    "/media/owl animals074.mp3",
    "/media/Peacock animals018.mp3",
    "/media/Peacock animals019.mp3",
    "/media/pelican.mp3",
    "/media/penguin.mp3",
    "/media/Pig squeal animals024.mp3",
    "/media/porcupine.mp3",
    "/media/rabbit.mp3",
    "/media/Rattlesnake  animals077.mp3",
    "/media/Rhinoceros animals134.mp3",
    "/media/Rooster animals070 1.mp3",
    "/media/Rooster animals070.mp3",
    "/media/Seagulls animals133.mp3",
    "/media/Sheep - ewe animals112.mp3",
    "/media/Sheep - ewe animals112(1).mp3",
    "/media/squirrel.mp3",
    "/media/tiger.mp3",
    "/media/turkey.mp3",
    "/media/whale.mp3",
    "/media/zebra.mp3"
];

self.addEventListener('install', function(event) {
  event.waitUntil(
    caches.open(mainCacheName).then(function(cache) {
      return cache.addAll(mp3Files);
    })
  );
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
        
        if(event.request.destination == "image" || event.request.destination == "audio"){
            event.respondWith(cacheFirst(event.request, false));
        }
        else{
            event.respondWith(cacheFirst(event.request, true));
            // event.respondWith(networkFirst(event.request));
        }
    }
    else {
        // let the browser do the default action
        return;
    }
}

async function cacheFirst(request, updateFromNetworkAfter) {
    try {
        const cachedResponse = await caches.match(request);
        if (cachedResponse) {
            if(updateFromNetworkAfter){
                try{
                    var response = await fetch(request);
                    if(response.status === 200){
                        const cache = await caches.open(mainCacheName);
                        cache.put(request, response.clone());
                    }
                }
                catch(error){
                    console.log('error:'+error);
                }
            }
            return cachedResponse
        }
    }
    catch (error) {
        console.debug('error in cacheFirst():'+error);
    }

    var response = await fetch(request);
    if(response.status === 200){
        const cache = await caches.open(mainCacheName);
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