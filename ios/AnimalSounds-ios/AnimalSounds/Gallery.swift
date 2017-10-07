//
//  Gallery.swift
//  AnimalSounds
//
//  Created by Sayed Ibrahim Hashimi on 10/2/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import Foundation
import UIKit

class GalleryItemCommentView : UICollectionReusableView {
    @IBOutlet var commentLabel: UILabel!
}

class GalleryItemCollectionViewCell : UICollectionViewCell {
     @IBOutlet var itemImageView: UIImageView!
    
    func setGalleryItem(_ item:GalleryItem) {
        itemImageView.image = UIImage(named: item.itemImage)
    }
    func setAnimal(_ name:String){
        itemImageView.image = UIImage(named: name)
    }
}

class GalleryItem {
    var itemImage: String
    
    init(dataDictionary:Dictionary<String,String>) {
        itemImage = dataDictionary["itemImage"]!
    }
    
    class func newGalleryItem(_ dataDictionary:Dictionary<String,String>) -> GalleryItem {
        return GalleryItem(dataDictionary: dataDictionary)
    }
}

class Animal {
    var name: String
    var imageFull: String
    var image: String
    var audio: String
    
    init(name: String, imageFull: String, image: String, audio: String){
        self.name = name
        self.imageFull = imageFull
        self.image = image
        self.audio = audio
    }
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let imageFull = json["imageFull"] as? String,
            let image = json["image"] as? String,
            let audio = json["audio"] as? String
        else {
                return nil
        }
        
        self.name = name
        self.image = image
        self.imageFull = imageFull
        self.audio = audio
    }
}










