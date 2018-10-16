// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your Javascript code.
window.addEventListener('load', async e => {
    console.log('load event');
    loadServiceWorker();
});

async function loadServiceWorker(){
    if ('serviceWorker' in navigator) {
        try {
            navigator.serviceWorker.register('/sw.js').then(function(registration) {
                console.log('Service worker registration succeeded:', registration);
            }, /*catch*/ function(error) {
                console.log('Service worker registration failed:', error);
            });
        }
        catch (error) {
            console.log('Service worker registration failed(2):',error);
        }
    }
}