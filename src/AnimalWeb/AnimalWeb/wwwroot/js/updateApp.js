const mainCacheName = 'sonyasapp-01';
window.addEventListener('load', async e => {
    console.log('SendUpdateAppToSw');
    navigator.serviceWorker.controller.postMessage("UpdateApp");
});