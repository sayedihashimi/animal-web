
window.addEventListener('load', async e => {
    console.log('load index page event');
    hookupEvents();
});

function hookupEvents(){
    var pics = document.getElementsByTagName("PICTURE");
    for(let pic of pics){
        pic.addEventListener("click", handleImageClick);
    }
}

function handleImageClick(element){
    if (!element || !(element.currentTarget)) {
        return;
    }

    try{
        var audioTagId = element.currentTarget.id.replace("pic-","audio-");
        document.getElementById(audioTagId).play();
    }
    catch(error){

    }
    
}