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
    var shuffle = VideoShuffleState.disabled
    var previouslyPlayed:[Int] = []
    var previouslyPlayedIndex = -1
    
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
    @IBAction func shuffleSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            shuffle = .disabled
        case 1:
            shuffle = .enabled
        default:
            shuffle = .disabled
        }
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
        var nextIndex = 0

        if(previouslyPlayedIndex > 0 && previouslyPlayedIndex < previouslyPlayed.count - 1 ){
            nextIndex = previouslyPlayedIndex
            previouslyPlayedIndex += 1
            return nextIndex
        }
        
        switch shuffle {
        case .disabled:
            nextIndex = (currentAnimalIndex+1)%(animalItems.count)
        case .enabled:
            nextIndex = RandomHelper.getRandomNumbersFrom(0, animalItems.count-1, 1)[0]
        }
        
        previouslyPlayedIndex = -1
        return nextIndex
    }
    
    func getPreviousAnimalIndex()->Int{
        var retvalue = 0
        
        if(previouslyPlayed.count <= 0){
            if( currentAnimalIndex - 1 < 0 ){
                retvalue = animalItems.count - 1
            }
            else {
                retvalue = currentAnimalIndex - 1
            }
        }
        else{
            if(previouslyPlayedIndex < 0){
                previouslyPlayedIndex = previouslyPlayed.count - 1
            }
            if(previouslyPlayedIndex >= previouslyPlayed.count){
                previouslyPlayedIndex = previouslyPlayed.count - 1
            }
            retvalue = previouslyPlayedIndex
            previouslyPlayedIndex -= 1
        }
        
        return retvalue
    }
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer?.stop()
        timer.invalidate()
    }
    @objc func loadNextAnimal(){
        if(videoState == .playing && !skipNextTimer) {
            let index = getNextAnimalIndex()
            previouslyPlayed.append(index)
            loadAndPlayAnimal(animalItems[index], index)
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
enum VideoShuffleState{
    case disabled
    case enabled
}
