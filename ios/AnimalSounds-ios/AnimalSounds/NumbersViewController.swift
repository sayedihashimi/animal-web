//
//  NumbersViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/8/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class NumbersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.autoresizesSubviews = true
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumbersItemCollectionViewCell", for: indexPath) as! NumbersItemCollectionViewCell
        
        cell.setNumber(indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let commentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NumbersItemCommentView", for: indexPath) as! NumbersItemCommentView
        
        commentView.setLabel(text: "Numbers")
        
        return commentView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return self.view.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did click")
    }
}


class NumbersItemCommentView : UICollectionReusableView {
    @IBOutlet var commentLabel: UILabel!
    
    func setLabel(text: String){
        commentLabel.text = text
    }
}

class NumbersItemCollectionViewCell : UICollectionViewCell {
    @IBOutlet var numberLabel: UILabel!
    
    func setNumber(_ item:Int) {
        numberLabel.text = String(item)
    }
}
