//
//  ViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/2/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var galleryItems: [GalleryItem] = []
    var animalItems: [Animal] = []
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        initGalleryItems()
        initAnimals()
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    fileprivate func initGalleryItems() {
        
        var items = [GalleryItem]()
        let inputFile = Bundle.main.path(forResource: "items", ofType: "plist")
        
        let inputDataArray = NSArray(contentsOfFile: inputFile!)
        
        for inputItem in inputDataArray as! [Dictionary<String, String>] {
            let galleryItem = GalleryItem(dataDictionary: inputItem)
            items.append(galleryItem)
        }
        
        galleryItems = items
    }
    
    fileprivate func initAnimals() {
        //var items = [Animal]()
        //let inputFile = Bundle.main.path(forResource: "animals", ofType: "json")
        
        do{
            if let path = Bundle.main.path(forResource: "animals", ofType: "json"){
                let jsonData = try NSData(contentsOfFile: path, options: .mappedIfSafe) as Data
                if(jsonData.count > 0){
                    
                    if let jsonResult = try JSONSerialization.jsonObject(with: jsonData) as? [NSDictionary] {
                        for json in jsonResult {
                            
                            let newanimal = Animal(name: json.value(forKey: "Name") as! String, imageFull: json.value(forKey: "ImageFull") as! String, image: json.value(forKey: "Image") as! String, audio: json.value(forKey: "Audio") as! String)
                            animalItems.append(newanimal)
                        }
                    }
                    else {
                        print("still empty")
                    }
                    
                    if let jsonResult: [Animal] = try JSONSerialization.jsonObject(with: jsonData) as? [Animal] {
                        for (_,animal) in jsonResult.enumerated() {
                            animalItems.append(animal)
                        }
                    } else {
                        print("empty")
                    }
                    
                }
            }
        } catch {
            print(error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return galleryItems.count
        return animalItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell

        //cell.setGalleryItem(galleryItems[indexPath.row])
        cell.setAnimal(animalItems[indexPath.row].imageFull)
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let commentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GalleryItemCommentView", for: indexPath) as! GalleryItemCommentView
        
        commentView.commentLabel.text = "Animal Sounds"
        
        return commentView
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playSound(name: animalItems[indexPath[1]].audio)
    }
    
    
    var audioPlayer: AVAudioPlayer?
    func playSound(name: String) {
        
        let soundName = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "wav")!)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! audioPlayer = AVAudioPlayer(contentsOf: soundName)
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // let picDimension = self.view.frame.size.width / 4.0
        // TODO: Revisit this
        
        var targetWidth = self.view.frame.size.width
        if(targetWidth > 300){
            targetWidth = self.view.frame.size.width / 2.0
        }
        
        return CGSize(width: self.view.frame.size.width, height: 200)
        
        // return CGSize(width:targetWidth, height: targetWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // let leftRightInset = self.view.frame.size.width / 14.0
        // let leftRightInset: CGFloat = 1.0
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
}

