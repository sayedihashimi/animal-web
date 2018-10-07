self.addEventListener('activate', function (event) {
    event.waitUntil(self.clients.claim()); // Become available to all pages
});


self.addEventListener('fetch', async event => {
   //handleFetch(event);
});
