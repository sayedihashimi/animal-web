//
//  TouchDownGestureRecognizer.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/10/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

// from https://stackoverflow.com/a/15629234/105999
class SingleTouchDownGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible {
            self.state = .recognized
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        // self.state = .failed
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        // self.state = .failed
    }
}
