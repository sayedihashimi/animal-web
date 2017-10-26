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
    var textItems: [TextItem] = []
    let speechHelper = SpeechHelper()
    var settingsHelper = SettingsHelper()
    
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

    func registerSwipeToNavigate() {
        // swipe gesture
        let swipeRightRec = UISwipeGestureRecognizer()
        swipeRightRec.addTarget(self, action: #selector(self.handleSwipeToNavigate))
        swipeRightRec.direction = .right
        collectionView.addGestureRecognizer(swipeRightRec)
        self.view.addGestureRecognizer(swipeRightRec)
        
        let swipeLeftRec = UISwipeGestureRecognizer()
        swipeLeftRec.addTarget(self, action: #selector(self.handleSwipeToNavigate))
        swipeLeftRec.direction = .left
        collectionView.addGestureRecognizer(swipeLeftRec)
        self.view.addGestureRecognizer(swipeLeftRec)
    }
    func registerSwipeToSpeak() {
        // swipe gesture
        let swipeRightRec = UISwipeGestureRecognizer()
        swipeRightRec.addTarget(self, action: #selector(self.handleSwipeToSpeak))
        swipeRightRec.direction = .right
        collectionView.addGestureRecognizer(swipeRightRec)
        self.view.addGestureRecognizer(swipeRightRec)
        
        let swipeLeftRec = UISwipeGestureRecognizer()
        swipeLeftRec.addTarget(self, action: #selector(self.handleSwipeToSpeak))
        swipeLeftRec.direction = .left
        collectionView.addGestureRecognizer(swipeLeftRec)
        self.view.addGestureRecognizer(swipeLeftRec)
    }
    @objc func handleSwipeToSpeak(gestureRecognizer: UISwipeGestureRecognizer) {
        let touchpoint = gestureRecognizer.location(ofTouch: 0, in: collectionView)
        if let item = collectionView.indexPathForItem(at: touchpoint) {
            speechHelper.speakText(textItems[item.row].speakText)
        }
    }
    @objc func handleSwipeToNavigate(gestureRecognizer: UISwipeGestureRecognizer) {
        print("swipped, direction: \(gestureRecognizer.direction)")
        // let newViewController = NumbersViewController()
        // self.navigationController?.pushViewController(newViewController, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "animalsViewController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    fileprivate func initItems() {
        for index in 0...self.settingsHelper.maxNumber {
            textItems.append(TextItem(displayText: String(index), speakText: String(index)))
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textItems.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumbersItemCollectionViewCell", for: indexPath) as! NumbersItemCollectionViewCell
        
        cell.setText(textItems[indexPath.row].displayText)
        
        if let label = cell.numberLabel {
            label.isUserInteractionEnabled = true
            label.tag = indexPath.row
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemTapped(tapGestureRecognizer:)))
            label.addGestureRecognizer(tapGestureRecognizer)
            
            if(self.view.frame.size.width < 500 || self.view.frame.size.height < 500){
                label.font = UIFont(name: label.font.fontName, size: 200)
            }
        }
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
    
    @objc func itemTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("itemTapped", separator: "", terminator: "")
        
        if let label = tapGestureRecognizer.view as! UILabel! {
            speechHelper.speakText(textItems[label.tag].speakText)
        }
    }
}

class TextItem {
    let displayText: String
    let speakText: String
    
    init(displayText: String, speakText: String) {
        self.displayText = displayText
        self.speakText = speakText
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
    
    func setText(_ text:String){
        numberLabel.text = text
    }
    func getText() -> String? {
        return numberLabel.text
    }
    
}
