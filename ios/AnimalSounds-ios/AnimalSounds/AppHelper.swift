//
//  AppHelper.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/22/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import Foundation

class AppHelper{
    enum Page{
        case Animals
        case Numbers
        case Shapes
    }
    struct PageId{
        static let Animals = "animalsViewController"
        static let Numbers = "numbersViewController"
        static let Shapes = "shapesViewController"
    }
}
