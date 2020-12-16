//
//  LettersViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/24/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class LettersViewController: BaseCollectionViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var letters: [TextItem] = []

    override func viewDidLoad() {
        super.cellReuseId = "LettersItemCollectionViewCell"
        super.headerReuseId = "LettersItemCommentView"
        super.viewDidLoad()
    }
    
    override func getCollectionView() -> UICollectionView {
        return collectionView
    }
    
    @objc override func handleSwipe(gestureRecognizer: UISwipeGestureRecognizer) {
        let touchpoint = gestureRecognizer.location(ofTouch: 0, in: collectionView)
        if let item = collectionView.indexPathForItem(at: touchpoint) {
            speechHelper.speakText(letters[item.row].speakText)
        }
    }
    
    override func initItems() {
        let startingValue = Int(("a" as UnicodeScalar).value) // 65
        for i in 0 ..< 26 {
            let cletter: String = String(Character(UnicodeScalar(i + startingValue)!))
            letters.append(TextItem(displayText: "\(cletter.uppercased()) \(cletter)", speakText: cletter))
        }
    }
    
    override func getItems() -> [AnyObject]{
        return letters
    }
    
    override func initCell(_ cell: UICollectionViewCell, _ colletionView: UICollectionView, cellForItemAt indexPath: IndexPath){
        let thecell = cell as! LettersItemCollectionViewCell
        
        thecell.setText(letters[indexPath.row].displayText)
        
        if let label = thecell.letterLabel {
            label.isUserInteractionEnabled = true
            label.tag = indexPath.row
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemTapped(tapGestureRecognizer:)))
            label.addGestureRecognizer(tapGestureRecognizer)
            
            if(self.view.frame.size.width < 500 || self.view.frame.size.height < 500){
                label.font = UIFont(name: label.font.fontName, size: 200)
            }
        }
    }
    override func initHeader(_ header: UICollectionReusableView, _ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath){
        
        let theheader = header as! LettersItemCommentView
        theheader.setLabel(text: "Letters")
    }

    @objc override func itemTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let label = tapGestureRecognizer.view as! UILabel? {
            speechHelper.speakText(letters[label.tag].speakText)
        }
    }
}

class LettersItemCommentView : UICollectionReusableView {
    @IBOutlet var commentLabel: UILabel!
    
    func setLabel(text: String){
        commentLabel.text = text
    }
}

class LettersItemCollectionViewCell : UICollectionViewCell {
    @IBOutlet var letterLabel: UILabel!
    
    func setText(_ text:String){
        letterLabel.text = text
    }
    func getText() -> String? {
        return letterLabel.text
    }
    
}
