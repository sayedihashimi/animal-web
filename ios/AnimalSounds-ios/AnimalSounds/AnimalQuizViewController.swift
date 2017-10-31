//
//  AnimalQuizViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/29/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class BaseUIViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    let speechHelper = SpeechHelper()
    
    func playSound(name: String) {
        
        let soundName = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "wav")!)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! audioPlayer = AVAudioPlayer(contentsOf: soundName)
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
    }
    
    func speakText(text: String) {
        speechHelper.speakText(text)
    }
}

class AnimalQuizViewController : BaseUIViewController {
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var soundOrNameSegment: UISegmentedControl!
    
    var animalItems: [Animal] = []
    var randomIndex: [Int] = []
    var currentIndex = 0
    var displayedAnimals:[Animal]=[]
    var selectedAnimal:Animal? = nil
    var selectedIndex = 0
    
    @IBAction func handlNextButtonTap(_ sender: UIButton) {
        updateViewWithNewAnimals()
    }
    
    @IBAction func handleReplayTap(_ sender: UIButton) {
        playCurrentAnimal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initItems()
        initGestures()
        updateViewWithNewAnimals()
    }
    
    func initItems(){
        animalItems = Animal.readFromJsonResource(name: "animals")
        randomIndex.removeAll()
        for i in 0..<animalItems.count {
            randomIndex.append(i)
        }
        randomIndex.shuffle()
    }
   
    func initGestures(){
        image1.tag = 0
        image2.tag = 1
        image3.tag = 2
        let imgs: [UIImageView] = [image1, image2, image3]
        for imgview in imgs {
            imgview.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imgview.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        // if the tag == selectedIndex correct one was picked
        if let tappedImage = tapGestureRecognizer.view as! UIImageView! {
            // playSound(name: animalItems[tappedImage.tag].audio)
            // playAnimal(animalItems[tappedImage.tag])
            if(tappedImage.tag == selectedIndex) {
                playSound(name: "applause3")
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                    self.updateViewWithNewAnimals()
                })
            }
        }
    }
    
    func updateViewWithNewAnimals(){
        // get three random animals and add to UI
        let animalsToDisplay:[Animal] = RandomHelper.getRandomElement(animalItems, 3)
        //var selectedIndex:Int = RandomHelper.getRandomElement(Array(0...2), 1)[0]
        
        image1.image = UIImage(named: animalsToDisplay[0].imageFull)
        image2.image = UIImage(named: animalsToDisplay[1].imageFull)
        image3.image = UIImage(named: animalsToDisplay[2].imageFull)
        
        let imageArray: [UIImageView] = [image1, image2, image3]
        
        // update displayed animals and the selected one
        displayedAnimals = animalsToDisplay
        selectedIndex = RandomHelper.getRandomElement(Array(0...2), 1)[0]
        selectedAnimal = displayedAnimals[selectedIndex]

        // play the sound of the selected animal
        playCurrentAnimal()
    }
    
    func playCurrentAnimal(){
        // see what action is selected in the segment control
        switch getSelectedAnimalAction() {
        case .PlaySound:
            playSound(name: selectedAnimal!.audio)
        case .SayName:
            speakText(text: selectedAnimal!.name)
        default:
            playSound(name: selectedAnimal!.audio)
        }
    }
    func getSelectedAnimalAction() -> AnimalAction {
        switch soundOrNameSegment.selectedSegmentIndex {
        case 0:
            return AnimalAction.PlaySound
        case 1:
            return AnimalAction.SayName
        default:
            return AnimalAction.PlaySound
        }
    }
}

class RandomHelper {
    static func getRandomNumbersFrom(_ start:Int, _ end:Int, _ numElementsToReturn:Int) -> [Int]{
        var result:[Int] = []
        
        var indexarray:[Int] = []
        for i in start...end {
            indexarray.append(i)
        }
        
        indexarray.shuffle()
        
        var index = 0
        while(result.count < numElementsToReturn) {
            result.append(indexarray[index])
            index += 1
        }
        
        return result
    }
    
    static func getRandomElement<T>(_ items: [T], _ numItems: Int) -> [T] {
        let randomIndexes = getRandomNumbersFrom(0, items.count-1, numItems)
        
        var result: [T] = []
        for i in randomIndexes {
            result.append(items[i])
        }
        return result
    }
}


















