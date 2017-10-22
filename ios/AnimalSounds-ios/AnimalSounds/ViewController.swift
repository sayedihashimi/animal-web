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

    var animalItems: [Animal] = []
    @IBOutlet var collectionView: UICollectionView!
    var action = AnimalAction.PlaySound
    let speakHelper = SpeakHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.autoresizesSubviews = true
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        initAnimals()
        registerSwipeToPlay()
        //registerSwipeToNavigate()
        collectionView.reloadData()
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
    func registerSwipeToPlay() {
        // swipe gesture
        let swipeRightRec = UISwipeGestureRecognizer()
        swipeRightRec.addTarget(self, action: #selector(self.handleSwipeToPlay))
        swipeRightRec.direction = .right
        collectionView.addGestureRecognizer(swipeRightRec)
        self.view.addGestureRecognizer(swipeRightRec)
        
        let swipeLeftRec = UISwipeGestureRecognizer()
        swipeLeftRec.addTarget(self, action: #selector(self.handleSwipeToPlay))
        swipeLeftRec.direction = .left
        collectionView.addGestureRecognizer(swipeLeftRec)
        self.view.addGestureRecognizer(swipeLeftRec)
    }
    @objc func handleSwipeToNavigate(gestureRecognizer: UISwipeGestureRecognizer) {
        print("swipped, direction: \(gestureRecognizer.direction)")
        // let newViewController = NumbersViewController()
        // self.navigationController?.pushViewController(newViewController, animated: true)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "numbersViewController") as! NumbersViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    @objc func handleSwipeToPlay(gestureRecognizer: UISwipeGestureRecognizer) {
        let touchpoint = gestureRecognizer.location(ofTouch: 0, in: collectionView)
        if let item = collectionView.indexPathForItem(at: touchpoint) {
            playSound(name: animalItems[item.row].audio)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    fileprivate func initAnimals() {
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
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

        cell.setAnimal(animalItems[indexPath.row].imageFull)
        
        if let imageView = cell.itemImageView {
            imageView.tag = indexPath.row
            imageView.isUserInteractionEnabled = true
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
        
        return cell
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let tappedImage = tapGestureRecognizer.view as! UIImageView! {
            // playSound(name: animalItems[tappedImage.tag].audio)
            playAnimal(animalItems[tappedImage.tag])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let commentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GalleryItemCommentView", for: indexPath) as! GalleryItemCommentView
        
        commentView.commentLabel.text = "Animal Sounds"
        
        
        return commentView
    }
    
    @IBAction func soundNameIndexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            action = .PlaySound
        case 1:
            action = .SayName
        default:
            action = .SayName
        }
    }
    
    func playAnimal(_ animal: Animal){
        // see if the switch is set to name or sound
        switch action {
        case .PlaySound:
            playSound(name: animal.audio)
        case .SayName:
            speakHelper.speakText(animal.name)
        default:
            playSound(name: animal.audio)
        }
    }
    
    enum AnimalAction {
        case PlaySound
        case SayName
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

        let devSize = self.view.frame.size
        let numColumns = 1
        
        let imgname = animalItems[indexPath.row].imageFull

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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // let leftRightInset = self.view.frame.size.width / 14.0
        // let leftRightInset: CGFloat = 1.0
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
}

class SpeakHelper {
    var voiceName = "Samantha"
    var language = "English"
    let synth = AVSpeechSynthesizer()
    let translationManager = TranslationManager()
    
    init(){
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(SpeakHelper.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
    }
    
    // will get the translation
    func getTextToSpeak(_ string: String, _ language: String, _ voiceName: String) -> String{
        return translationManager.getTranslatedString(string, language)
    }
    
    func speakText(_ text: String){
        
        let speakText = getTextToSpeak(text, language, voiceName)
        
        let myUtterance = AVSpeechUtterance(string: speakText)
        
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
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    @objc func defaultsChanged(){
        if let languageSettingName = UserDefaults.standard.string(forKey: SettingsBundleHelper.SettingsBundleKeys.Language) {
            language = languageSettingName
            voiceName = translationManager.getVoiceName(forLanguage: language, "Samantha")
        }
    }
}

class TranslationManager{
    var translations: [String: Translation] = [String: Translation]()
    
    init(){
        let hindi = Translation.getFromFile("strings.Hindi")
        if(hindi.language.count > 1){
            translations["hindi"] = hindi
        }
    }
    
    func getTranslation(_ forLanguage: String) -> Translation {
        return Translation("","",[String: String]())
    }
    
    func getTranslatedString(_ text: String, _ language: String) -> String {
        let langLower = language.lowercased()
        let textLower = text.lowercased()
        if(translations.keys.contains(langLower)) {
            if let result = translations[langLower]?.translatedStrings[textLower] {
                if(result.count > 1){
                    return result
                }
            }
        }
        
        return text
    }
    
    func getVoiceName(forLanguage language: String, _ defaultValue: String) -> String{
        let langLower = language.lowercased()
        if let t = translations[langLower] {
            return t.voiceName
        }
        return defaultValue
    }
}

class Translation {
    let voiceName: String
    let language: String
    
    var translatedStrings = [String: String]()
    
    init(_ voiceName: String, _ language: String, _ translatedStrings: [String: String]){
        self.voiceName = voiceName
        self.language = language
        self.translatedStrings = translatedStrings
    }
    
    static func getFromFile(_ filename: String) -> Translation {
        do {
            if let path = Bundle.main.path(forResource: filename, ofType: "json") {
                let jsonData = try NSData(contentsOfFile: path, options: .mappedIfSafe) as Data
                if(jsonData.count > 0){
                    if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary {
                        // var voice: String? = json.value(forKey: "Image")
                        // var lang: String? = json.value(forKey: "")
                        // (jsonResult["settings"] as! NSDictionary)["voiceName"] as! String
                        
                        if let settings = jsonResult["settings"] as? NSDictionary {
                        if let voice = settings.value(forKey: "voiceName") as? String{
                        if let lang = settings.value(forKey: "language") as? String {
                        if let translations = jsonResult["translations"] as? [String: String] {
                            return Translation(voice,lang,translations)
                        }}}}
                    }
                }
            }
        } catch {
            return Translation("","", [String: String]())
        }

        return Translation("","",[String: String]())
    }
}








/*
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
 */
















