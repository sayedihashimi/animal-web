//
//  SettingsBundleHelper.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/12/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import Foundation

class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let Language = "SONYA_LANGUAGE"
        static let PlayAnimalSound = "SONYA_SAY_ANIMAL_NAME"
        static let SayAnimalName = "SONYA_PLAY_ANIMAL_SOUND"
        static let MaxNumber = "SONYA_MAX_NUMBER"
    }
}

class SettingsHelper{
    var language = "English"
    var maxNumber = 25
    init(){
        registerSettingsBundle()
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsHelper.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)
        defaultsChanged()
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    @objc func defaultsChanged(){
        if let languageSettingName = UserDefaults.standard.string(forKey: SettingsBundleHelper.SettingsBundleKeys.Language) {
            language = languageSettingName
        }
        
        let maxNum = UserDefaults.standard.integer(forKey: SettingsBundleHelper.SettingsBundleKeys.MaxNumber)
        if maxNum > 0 {
            maxNumber = maxNum
        }
    }
}
