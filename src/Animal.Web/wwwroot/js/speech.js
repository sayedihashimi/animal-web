var lastTap = null;
var lastAudioElement = null;
function HandleImageTap(audioElement) {
    var currentTimeMilli = new Date().getTime();
    var timepassed = -1;

    if (lastTap != null) {
        timepassed = currentTimeMilli - lastTap;
    }
    lastTap = currentTimeMilli;

    console.log('timepassed: ' + timepassed);

    if (lastAudioElement != null && lastAudioElement != audioElement) {
        // stop playing and reset lastTap
        lastAudioElement.pause();
        lastAudioElement.currentTime = 0;
        timepassed = -1;
    }

    if (timepassed == -1 || timepassed > 1000) {
        console.log('playing audio now');

        if (lastAudioElement != null) {
            lastAudioElement.pause();
            lastAudioElement.currentTime = 0;
        }
        audioElement.play();
        lastTap = currentTimeMilli;
    }
    else {
        console.log('skipping audio play');
    }

    lastAudioElement = audioElement;
}
