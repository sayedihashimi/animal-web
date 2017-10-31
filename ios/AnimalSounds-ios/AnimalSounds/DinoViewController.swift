//
//  DinoViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/28/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class DinoViewController: BaseCollectionViewController {
    @IBOutlet var collectionView: UICollectionView!
    var dataItems: [DinoItem] = []
    var action: AnimalAction = .PlaySound
    
    override func viewDidLoad() {
        super.cellReuseId = "DinoCollectionViewCell"
        super.headerReuseId = "DinoHeaderView"
        super.viewDidLoad()
    }
    
    override func getCollectionView() -> UICollectionView {
        return collectionView
    }
    
    override func initItems() {
        if let path = Bundle.main.path(forResource: "dino", ofType: "json"){
            dataItems = DinoItem.ReadFromJsonFile(filepath: path)
        }
    }
    
    override func initCell(_ cell: UICollectionViewCell, _ colletionView: UICollectionView, cellForItemAt indexPath: IndexPath) {
        let thecell = cell as! DinoCollectionViewCell
        
        thecell.setDinosaur(dataItems[indexPath.row])
        
        if let imageView = thecell.dinoImage {
            imageView.tag = indexPath.row
            imageView.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemTapped(tapGestureRecognizer:)))
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
        
    }
    
    override func initHeader(_ header: UICollectionReusableView, _ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) {
        let theheader = header as! DinoHeaderView
        theheader.setHeaderText(text: "Dinosaurs")
    }
    
    override func getItems() -> [AnyObject] {
        return dataItems
    }
    
    override func handleSwipe(gestureRecognizer: UISwipeGestureRecognizer) {
        
    }
    @objc override func itemTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if let tappedItem = tapGestureRecognizer.view as! UIImageView! {
            playDino(dataItems[tappedItem.tag])
        }
    }
    
    @IBAction func soundOrNameSelectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            action = .PlaySound
        case 1:
            action = .SayName
        default:
            action = .PlaySound
        }
    }
    func playDino(_ dino:DinoItem){
        switch action {
        case .PlaySound:
            playSound(name: dino.audio)
        case .SayName:
            super.speechHelper.speakText(dino.name,VoiceNames.EnglishVoiceName)
        default:
            playSound(name: dino.audio)
        }
    }
}



class DinoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var dinoImage: UIImageView!
    
    func setDinosaur(_ dino:DinoItem){
        dinoImage.image = UIImage(named: dino.image)
    }
}

class DinoHeaderView: UICollectionReusableView {
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var segmentSoundOrName: UISegmentedControl!
    
    func setHeaderText(text:String){
        commentLabel.text = text
    }
}
