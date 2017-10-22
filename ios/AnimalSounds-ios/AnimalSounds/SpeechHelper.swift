//
//  Speech.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/21/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechHelper {
    var voiceName = "Samantha"
    var language = "English"
    let synth = AVSpeechSynthesizer()
    let translationManager = TranslationManager()
    
    init(){
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(SpeechHelper.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
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
        let langs = ["hindi","spanish","danish","portuguese","chinese"]
        for lang in langs {
            if let translation = Translation.getFromFile("strings.\(lang)") {
                translations[lang] = translation
            }
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
    
    static func getFromFile(_ filename: String) -> Translation? {
        do {
            if let path = Bundle.main.path(forResource: filename, ofType: "json") {
                let jsonData = try NSData(contentsOfFile: path, options: .mappedIfSafe) as Data
                if(jsonData.count > 0){
                    if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary {
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
            return nil
        }
        
        return nil
    }
}
