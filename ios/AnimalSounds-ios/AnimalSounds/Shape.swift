//
//  Shape.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/14/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import Foundation
import UIKit

class ShapesCommentViewCell : UICollectionReusableView {
    @IBOutlet var commentLabel: UILabel!
    
    func setLabel(text: String){
        commentLabel.text = text
    }
}

class ShapesCollectionViewCell : UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    
    func setImage(_ name: String) {
        image.image = UIImage(named: name)
    }
}

