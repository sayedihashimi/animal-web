//
//  BaseViewController.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/29/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import Foundation

import UIKit
import Foundation
import AVFoundation

class BaseCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var audioPlayer: AVAudioPlayer?
    // things that must be overridden by subclass
    // @IBOutlet var collectionView: UICollectionView!
    
    func getCollectionView() -> UICollectionView {
        fatalError(#function + "Must be overridden");
    }
    
    var cellReuseId = "cell-reuse-id"
    var headerReuseId = "header-reuse-id"
    
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
        
        getCollectionView().decelerationRate = UIScrollView.DecelerationRate.fast
        
        registerSwipe()
        getCollectionView().autoresizesSubviews = true
        getCollectionView().contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        getCollectionView().reloadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = getCollectionView().collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    
    func registerSwipe() {
        // swipe gesture
        let swipeRightRec = UISwipeGestureRecognizer()
        swipeRightRec.addTarget(self, action: #selector(self.handleSwipe))
        swipeRightRec.direction = .right
        getCollectionView().addGestureRecognizer(swipeRightRec)
        self.view.addGestureRecognizer(swipeRightRec)
        
        let swipeLeftRec = UISwipeGestureRecognizer()
        swipeLeftRec.addTarget(self, action: #selector(self.handleSwipe))
        swipeLeftRec.direction = .left
        getCollectionView().addGestureRecognizer(swipeLeftRec)
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
    
    func playSound(name: String) {
        
        let soundName = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "wav")!)
        
        try! AVAudioSession.sharedInstance().setCategory(.playback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! audioPlayer = AVAudioPlayer(contentsOf: soundName)
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
