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



class BaseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // things that must be overridden by subclass
    @IBOutlet var collectionView: UICollectionView!
    let cellReuseId = "cell-id-here"
    let headerReuseId = "header-id-here"
    
    func initItems() {
        fatalError(#function + "Must be overridden");
    }
    func initCell(_ cell: UICollectionViewCell, _ colletionView: UICollectionView, cellForItemAt indexPath: IndexPath){
        fatalError(#function + "Must be overridden");
    }
    func initHeader(_ header: UICollectionReusableView, _ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath){
       fatalError(#function + "Must be overridden");
    }
    func getItems() -> [AnyObject]{
        fatalError(#function + "Must be overridden");
    }
    // things that should be overridden by subclass
    @objc func handleSwipe(gestureRecognizer: UISwipeGestureRecognizer) {
    }
    @objc func itemTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    }

    // standard, no need to override
    let speechHelper = SpeechHelper()
    
    let minimumLineSpacingForSectionAt = CGFloat(0)
    let minimumInteritemSpacingForSectionAt = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initItems()
        
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        registerSwipe()
        collectionView.autoresizesSubviews = true
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.reloadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    
    func registerSwipe() {
        // swipe gesture
        let swipeRightRec = UISwipeGestureRecognizer()
        swipeRightRec.addTarget(self, action: #selector(self.handleSwipe))
        swipeRightRec.direction = .right
        collectionView.addGestureRecognizer(swipeRightRec)
        self.view.addGestureRecognizer(swipeRightRec)
        
        let swipeLeftRec = UISwipeGestureRecognizer()
        swipeLeftRec.addTarget(self, action: #selector(self.handleSwipe))
        swipeLeftRec.direction = .left
        collectionView.addGestureRecognizer(swipeLeftRec)
        self.view.addGestureRecognizer(swipeLeftRec)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getItems().count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacingForSectionAt
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacingForSectionAt
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath)
        initCell(cell, collectionView, cellForItemAt: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseId, for: indexPath)
        
        initHeader(header, collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        
        return header
    }
}

class LettersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    var letters: [TextItem] = []
    var maxNumber = 25
    let speechHelper = SpeechHelper()
    
    let minimumLineSpacingForSectionAt = CGFloat(0)
    let minimumInteritemSpacingForSectionAt = CGFloat(0)
    
    let cellReuseId = "LettersItemCollectionViewCell"
    let headerReuseId = "LettersItemCommentView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initItems()
        
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        registerSwipeToSpeak()
        collectionView.autoresizesSubviews = true
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.reloadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    
    func registerSwipeToSpeak() {
        // swipe gesture
        let swipeRightRec = UISwipeGestureRecognizer()
        swipeRightRec.addTarget(self, action: #selector(self.handleSwipe))
        swipeRightRec.direction = .right
        collectionView.addGestureRecognizer(swipeRightRec)
        self.view.addGestureRecognizer(swipeRightRec)
        
        let swipeLeftRec = UISwipeGestureRecognizer()
        swipeLeftRec.addTarget(self, action: #selector(self.handleSwipe))
        swipeLeftRec.direction = .left
        collectionView.addGestureRecognizer(swipeLeftRec)
        self.view.addGestureRecognizer(swipeLeftRec)
    }
    
    @objc func handleSwipe(gestureRecognizer: UISwipeGestureRecognizer) {
        let touchpoint = gestureRecognizer.location(ofTouch: 0, in: collectionView)
        if let item = collectionView.indexPathForItem(at: touchpoint) {
            speechHelper.speakText(letters[item.row].speakText)
        }
    }
    
    func initItems() {
        let startingValue = Int(("a" as UnicodeScalar).value) // 65
        for i in 0 ..< 26 {
            let cletter: String = String(Character(UnicodeScalar(i + startingValue)!))
            letters.append(TextItem(displayText: "\(cletter.uppercased()) \(cletter)", speakText: cletter))
        }
    }
    
    func getItems() -> [AnyObject]{
        return letters
    }
    
    func initCell(_ cell: UICollectionViewCell, _ colletionView: UICollectionView, cellForItemAt indexPath: IndexPath){
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
    func initHeader(_ header: UICollectionReusableView, _ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath){
        
        let theheader = header as! LettersItemCommentView
        theheader.setLabel(text: "Letters")
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getItems().count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacingForSectionAt
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacingForSectionAt
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath)
        initCell(cell, collectionView, cellForItemAt: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseId, for: indexPath)
        
        initHeader(header, collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        
        return header
    }

    @objc func itemTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let label = tapGestureRecognizer.view as! UILabel! {
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
