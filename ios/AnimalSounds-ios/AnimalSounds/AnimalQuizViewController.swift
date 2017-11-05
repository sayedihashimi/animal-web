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
import AudioToolbox

class AnimalQuizViewController : BaseAnimalViewController {
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var soundOrNameSegment: UISegmentedControl!
    @IBOutlet var successLabel1: UILabel!
    @IBOutlet var successLabel2: UILabel!
    @IBOutlet var successLabel3: UILabel!
    @IBOutlet var animalStack: UIStackView!
    @IBOutlet var stackBottomConstraint: NSLayoutConstraint!
    @IBOutlet var stackTopConstraint: NSLayoutConstraint!
    
    // var animalItems: [Animal] = []
    var randomIndex: [Int] = []
    var currentIndex = 0
    var displayedAnimals:[Animal]=[]
    var selectedAnimal:Animal? = nil
    var selectedIndex = 0
    var verticalConstraints:[NSLayoutConstraint] = []
    var horizontalConstraints:[NSLayoutConstraint] = []
    
    @IBAction func handlNextButtonTap(_ sender: UIButton) {
        updateViewWithNewAnimals()
    }
    
    @IBAction func handleReplayTap(_ sender: UIButton) {
        playCurrentAnimal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateVisibilityOfSuccessUi(true)
        
        initItems()
        initGestures()
        updateViewWithNewAnimals()
        initConstraints()
        
        setAxis(self.view.frame.size)
    }
    
    func updateVisibilityOfSuccessUi(_ isHidden:Bool){
        successLabel1.isHidden = isHidden
        successLabel2.isHidden = isHidden
        successLabel3.isHidden = isHidden
    }
    
    func initItems(){
        randomIndex.removeAll()
        for i in 0..<animalItems.count {
            randomIndex.append(i)
        }
        randomIndex.shuffle()
    }
    func initConstraints(){
        verticalConstraints.append(animalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 80))
        verticalConstraints.append(animalStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80))
        
        horizontalConstraints.append(stackTopConstraint)
        horizontalConstraints.append(stackBottomConstraint)
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
            if(tappedImage.tag == selectedIndex) {
                image1.isUserInteractionEnabled = false
                image2.isUserInteractionEnabled = false
                image3.isUserInteractionEnabled = false
                updateVisibilityOfSuccessUi(false)
                playSound(name: "applause3")
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                    self.updateViewWithNewAnimals()
                })
            }
            else {
                playWrongAnswer()
            }
        }
    }
    
    func playWrongAnswer(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        playSound(name: "wrong-answer")
    }
    
    func updateViewWithNewAnimals(){
        updateVisibilityOfSuccessUi(true)
        // get three random animals and add to UI
        let animalsToDisplay:[Animal] = RandomHelper.getRandomElement(animalItems, 3)
        //var selectedIndex:Int = RandomHelper.getRandomElement(Array(0...2), 1)[0]
        
        image1.image = UIImage(named: animalsToDisplay[0].imageFull)
        image2.image = UIImage(named: animalsToDisplay[1].imageFull)
        image3.image = UIImage(named: animalsToDisplay[2].imageFull)
        
        let imageArray: [UIImageView] = [image1, image2, image3]
        
        for img in imageArray {
            img.isUserInteractionEnabled = true
        }
        
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
    func setAxis(_ size: CGSize){
        // let size = self.view.frame.size
        
        if(size.height > size.width){
            animalStack.axis = .vertical
            for vc in verticalConstraints {
                vc.isActive = true
            }
            for hc in horizontalConstraints {
                hc.isActive = false
            }
        }
        else {
            animalStack.axis = .horizontal
            for vc in verticalConstraints {
                vc.isActive = false
            }
            for hc in horizontalConstraints {
                hc.isActive = true
            }
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        setAxis(size)
    }
}
