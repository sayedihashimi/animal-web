//
//  BaseAnimalViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 11/4/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import AudioToolbox

class BaseAnimalViewController : BaseUIViewController {
    var animalItems: [Animal] = []
    
    init(){
        super.init(nibName: nil, bundle: nil)
        initAnimals()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initAnimals()
    }
    
    func initAnimals(){
        animalItems = Animal.readFromJsonResource(name: "animals")
    }
}
