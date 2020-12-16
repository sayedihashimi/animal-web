//
//  BaseUIViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 11/4/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import AudioToolbox

class BaseUIViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    let speechHelper = SpeechHelper()

    func playSound(name: String) {
        
        let soundName = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "wav")!)
        
        try! AVAudioSession.sharedInstance().setCategory(.playback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! audioPlayer = AVAudioPlayer(contentsOf: soundName)
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
    }
    
    func speakText(text: String) {
        speechHelper.speakText(text)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
