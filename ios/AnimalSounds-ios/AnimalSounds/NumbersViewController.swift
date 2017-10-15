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
    let synth = AVSpeechSynthesizer()
    var textItems: [TextItem] = []
    var voiceName: String = "Samantha"
    var maxNumber = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSettings()
        initItems()
        
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast

        //registerSwipeToNavigate()
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
    
    func initSettings() {
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(NumbersViewController.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
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
            sayText(text: textItems[item.row].speakText)
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
        for index in 0...self.maxNumber {
            textItems.append(TextItem(displayText: String(index), speakText: String(index)))
        }
        
        let startingValue = Int(("a" as UnicodeScalar).value) // 65
        for i in 0 ..< 26 {
            let cletter: String = String(Character(UnicodeScalar(i + startingValue)!))
            textItems.append(TextItem(displayText: "\(cletter.uppercased()) \(cletter)", speakText: cletter))
        }
    }
    
    func registerSettingsBundle() {
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    @objc func defaultsChanged() {
        if let voiceSettingValue =  UserDefaults.standard.string(forKey: SettingsBundleHelper.SettingsBundleKeys.Language) {
            self.voiceName = voiceSettingValue
        }
        let maxnumvalue = UserDefaults.standard.integer(forKey: SettingsBundleHelper.SettingsBundleKeys.MaxNumber)
        self.maxNumber = maxnumvalue
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
            sayText(text: textItems[label.tag].speakText)
        }
    }
    
    fileprivate func sayText(text: String){
        let myUtterance = AVSpeechUtterance(string: text)
        if let voice = getVoice(forName: voiceName) {
           myUtterance.voice = voice
        }
        synth.speak(myUtterance)
    }
    
    func getVoice(forName name: String) -> AVSpeechSynthesisVoice? {
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            if #available(iOS 9.0, *) {
                if voice.name == name {
                    return voice
                }
            }
        }
        
        return nil
    }
    /*
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging ", separator: "", terminator: "")
        snapToNearestCell(scrollView: collectionView!)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating ", separator: "", terminator: "")
        snapToNearestCell(scrollView: collectionView!)
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation ", separator: "", terminator: "")
        snapToNearestCell(scrollView: collectionView!)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll ", separator: "", terminator: "")
        snapToNearestCell(scrollView: collectionView!)
    }
    func snapToNearestCell(scrollView: UICollectionView) {
        print("snapToNearestCell called")
        //pick first cell to get width
        let indexPath = IndexPath(item: 0, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) as! NumbersItemCollectionViewCell? {
            let cellWidth = cell.bounds.size.width
            
            for i in 0..<collectionView.numberOfItems(inSection: 0) {
                if scrollView.contentOffset.x <= CGFloat(i) * cellWidth + cellWidth / 2 {
                    let indexPath = NSIndexPath(item: i, section: 0)
                    
                    collectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
                    break
                }
            }
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        
        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
        
        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
 */
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
