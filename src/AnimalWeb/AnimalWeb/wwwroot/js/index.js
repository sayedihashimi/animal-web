
window.addEventListener('load', async e => {
    console.log('load index page event');
    hookupEvents();
});

var audioTags;

function hookupEvents(){
    var pics = document.getElementsByTagName("PICTURE");
    for(let pic of pics){
        pic.addEventListener("click", handleImageClick);
    }

    audioTags = document.getElementsByTagName("AUDIO");
}

function handleImageClick(element){
    if (!element || !(element.currentTarget)) {
        return;
    }

    try{
        var audioTagId = element.currentTarget.id.replace("pic-","audio-");
        var audio = document.getElementById(audioTagId);

        for(let atag of audioTags){
            atag.pause();
        }

        audio.currentTime = 0;
        audio.play();
    }
    catch(error){

    }
    
}