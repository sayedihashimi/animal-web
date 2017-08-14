/*
 * Check for browser support
 */
//var supportMsg = document.getElementById('msg');

//if ('speechSynthesis' in window) {
//	supportMsg.innerHTML = 'Your browser <strong>supports</strong> speech synthesis.';
//} else {
//	supportMsg.innerHTML = 'Sorry your browser <strong>does not support</strong> speech synthesis.<br>Try this in <a href="https://www.google.co.uk/intl/en/chrome/browser/canary.html">Chrome Canary</a>.';
//	supportMsg.classList.add('not-supported');
//}


// Get the 'speak' button
//var button = document.getElementById('speak');

// Get the text input element.
//var speechMsgInput = document.getElementById('speech-msg');

// Get the voice select element.
// var voiceSelect = document.getElementById('voice');

// Get the attribute controls.
// var volumeInput = document.getElementById('volume');
// var rateInput = document.getElementById('rate');
// var pitchInput = document.getElementById('pitch');


//// Fetch the list of voices and populate the voice options.
//function loadVoices() {
//  // Fetch the available voices.
//	var voices = speechSynthesis.getVoices();
  
//  // Loop through each of the voices.
//	voices.forEach(function(voice, i) {
//    // Create a new option element.
//		var option = document.createElement('option');
    
//    // Set the options value and text.
//		option.value = voice.name;
//		option.innerHTML = voice.name;
		  
//    // Add the option to the voice selector.
//		voiceSelect.appendChild(option);
//	});
//}

//// Execute loadVoices.
// loadVoices();

// Chrome loads voices asynchronously.
//window.speechSynthesis.onvoiceschanged = function(e) {
//  loadVoices();
//};


// Create a new utterance for the specified text and add it to
// the queue.
function speak(text) {
    // Create a new instance of SpeechSynthesisUtterance.
	var msg = new SpeechSynthesisUtterance();
    // alert(msg);
    // Set the text.
	msg.text = text;
  
    // Set the attributes.
    //msg.volume = 1;         //parseFloat(volumeInput.value);
    //msg.rate = 1;           //parseFloat(rateInput.value);
    //msg.pitch = 1;          // parseFloat(pitchInput.value);
  
    //msg.voice = 'Melina';

    //var v = GetPerferredVoice();
    //if (v != null) {
    //    msg.voice = v;
    //}

    // Queue this utterance.
	window.speechSynthesis.speak(msg);
}


async function sayThenPlay(text, audioElement) {
    //var msg = new SpeechSynthesisUtterance();
    //msg.text = text;
    //window.speechSynthesis.speak(msg);

    //while (window.speechSynthesis.speaking == true) {
    //    await sleep(50);
    //}
    //await sleep(2000);

    //await window.sleep(2000);

    audioElement.play();
}

function GetPerferredVoice() {
    var v = speechSynthesis.getVoices().filter(function (voice) { return voice.name == 'Melina'; })[0];
    return v;
}

// Set up an event listener for when the 'speak' button is clicked.
//button.addEventListener('click', function(e) {
//	if (speechMsgInput.value.length > 0) {
//		speak(speechMsgInput.value);
//	}
//});
