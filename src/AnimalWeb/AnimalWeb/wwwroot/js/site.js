// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your Javascript code.
window.addEventListener('load', async e => {
    console.log('load event');
    if ('serviceWorker' in navigator) {
        try {
            navigator.serviceWorker.register('sw.js');
            console.log('SW registered');
        }
        catch (error) {
            console.log('error');
        }
    }
});