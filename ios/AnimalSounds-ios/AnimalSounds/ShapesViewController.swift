//
//  ShapesViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/14/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ShapesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    let synth = AVSpeechSynthesizer()
    var shapeItems: [DataItem] = []
    var voiceName: String = "Samantha"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.autoresizesSubviews = true
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        initSettings()
        initDataItems()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    // this method will need to be implemented by each viewcontroller
    func initDataItems(){
        if let path = Bundle.main.path(forResource: "shapes", ofType: "json"){
            shapeItems = DataItem.ReadFromJsonFile(filepath: path)
        }
    }
    
    // Move to base class
    // Settings related
    func initSettings() {
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(ShapesViewController.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
    }
    func registerSettingsBundle() {
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    @objc func defaultsChanged() {
        if let voiceSettingValue =  UserDefaults.standard.string(forKey: SettingsBundleHelper.SettingsBundleKeys.Language) {
            self.voiceName = voiceSettingValue
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapeItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShapesCollectionViewCell", for: indexPath) as! ShapesCollectionViewCell
        cell.setImage(shapeItems[indexPath.row].image!)
        cell.tag = indexPath.row
        
        if let imgView = cell.image {
            imgView.isUserInteractionEnabled = true
            imgView.tag = indexPath.row
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imgView.addGestureRecognizer(tapGestureRecognizer)
        }
        
        return cell
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let tappedImage = tapGestureRecognizer.view as! UIImageView! {
            sayText(text: shapeItems[tappedImage.tag].name)
        }
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
    func printAllVoices(){
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            if #available(iOS 9.0, *) {
                print("name:[\(voice.name)] language:[\(voice.language)] id:[\(voice.identifier)] ")
            }
        }
    }
    */
    fileprivate func sayText(text: String){
        let myUtterance = AVSpeechUtterance(string: text)
        if let voice = getVoice(forName: voiceName) {
            myUtterance.voice = voice
        }
        synth.speak(myUtterance)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let commentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ShapesCommentViewCell", for: indexPath) as! ShapesCommentViewCell
        
        commentView.setLabel(text: "Shapes")
        
        return commentView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var sizeValues = [self.view.frame.size.height,self.view.frame.size.width]
        
        var width = sizeValues.max()
        var height = sizeValues.min()
        
        return CGSize(width: width!, height: height!)
        /*
        let devSize = self.view.frame.size
        let numColumns = 1
        
        let imgname = shapeItems[indexPath.row].image!
        
        // assume landscape
        
        if let currentImg = UIImage(named: imgname) {
            if(Float(currentImg.size.height) > Float(currentImg.size.width)){
                // set size based on height
                let imgHeight2 = self.view.frame.size.height
                let imgWidth2 = imgHeight2 * (currentImg.size.height/currentImg.size.height)
                return CGSize(width:imgWidth2, height: imgHeight2)
            } else {
                // set size based on width
                let imgWidth3 = self.view.frame.size.width
                let imgHeight3 = imgWidth3 * (currentImg.size.height/currentImg.size.width)
                return CGSize(width:imgWidth3, height: imgHeight3)
            }
        }
        
        
        let imgHeight = (devSize.height) / CGFloat(numColumns)
        let imgWidth = imgHeight * (devSize.width/devSize.height)
        
        return CGSize(width:imgWidth, height: imgHeight)
        */
    }
}
