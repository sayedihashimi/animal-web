//
//  RandomHelper.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 11/3/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import Foundation

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
