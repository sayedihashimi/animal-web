//
//  AnimalVideoViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 11/4/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import Foundation
import UIKit

class AnimalVideoViewController: BaseAnimalViewController {
    @IBOutlet var animalImageView: UIImageView!
    @IBOutlet var playPauseButton: UIButton!
    
    var currentAnimalIndex = 0
    var currentAnimal:Animal?
    var timer = Timer()
    var videoState = VideoState.paused
    var skipNextTimer = false
    
    @IBAction func playPauseClicked(_ sender: Any) {
        switch videoState {
        case .playing:
            videoState = .paused
            audioPlayer?.stop()
            //playPauseButton.image = UIImage(named: "paused")
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        case .paused:
            videoState = .playing
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func rewindTapped(_ sender: UIButton) {
        let index = getPreviousAnimalIndex()
        playAndDelay(animalItems[index], index)
    }
    @IBAction func fastForwardTapped(_ sender: Any) {
        let index = getNextAnimalIndex()
        playAndDelay(animalItems[index], index)
    }
    @IBAction func replayTapped(_ sender: Any) {
        replayCurrentAnimal()
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        replayCurrentAnimal()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoState = .playing
        // show and play first animal
        loadAndPlayAnimal(animalItems[0], 0)
        
        animalImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        animalImageView.addGestureRecognizer(tapGestureRecognizer)
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 3, target: self,   selector: (#selector(AnimalVideoViewController.loadNextAnimal)), userInfo: nil, repeats: true)
    }
    func replayCurrentAnimal(){
        skipNextTimer = true
        playAnimal(currentAnimal!)
    }
    func playAndDelay(_ animal:Animal,_ index:Int){
        loadAndPlayAnimal(animal, index)
        skipNextTimer = true
    }
    
    func getNextAnimalIndex()->Int{
        return (currentAnimalIndex+1)%(animalItems.count)
    }
    
    func getPreviousAnimalIndex()->Int{
        if( currentAnimalIndex - 1 < 0 ){
            return animalItems.count - 1
        }
        else {
            return currentAnimalIndex - 1
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer?.stop()
        timer.invalidate()
    }
    @objc func loadNextAnimal(){
        if(videoState == .playing && !skipNextTimer) {
            let index = getNextAnimalIndex()
            loadAndPlayAnimal(animalItems[index], index)
//            currentAnimalIndex = (currentAnimalIndex+1)%(animalItems.count)
//
//            let currentAnimal = animalItems[currentAnimalIndex]
//            animalImageView.image = UIImage(named: currentAnimal.imageFull)
//            playAnimal(currentAnimal)
        }

        skipNextTimer = false
    }
    
    func loadAndPlayAnimal(_ animal:Animal, _ index:Int) {
        currentAnimal = animal
        currentAnimalIndex = index
        animalImageView.image = UIImage(named: animal.imageFull)
        playAnimal(animal)
    }
    
    func playAnimal(_ animal:Animal){
        super.audioPlayer?.stop()
        playSound(name: animal.audio)
    }
}

enum VideoState {
    case playing
    case paused
}
