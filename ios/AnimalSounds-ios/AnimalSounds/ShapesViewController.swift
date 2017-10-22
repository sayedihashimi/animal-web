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
    var shapeItems: [DataItem] = []
    let speechHelper = SpeechHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.autoresizesSubviews = true
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
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
            speechHelper.speakText(shapeItems[tappedImage.tag].name)
        }
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
