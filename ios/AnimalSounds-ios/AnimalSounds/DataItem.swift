//
//  DataItem.swift
//  AnimalSounds
//
//  Created by Sayed Hashimi on 10/14/17.
//  Copyright © 2017 Sayed Ibrahim Hashimi. All rights reserved.
//

import Foundation

class DataItem {
    let id: String
    let name: String
    let image: String?
    
    init(id: String, name: String, image: String?){
        self.id = id
        self.name = name
        self.image = image
    }
    
    static func ReadFromJsonFile(filepath: String) -> [DataItem] {
        var result: [DataItem] = []
        
        do {
            let jsonData = try NSData(contentsOfFile: filepath, options: .mappedIfSafe) as Data
            if(jsonData.count > 0){
                if let jsonResult = try JSONSerialization.jsonObject(with: jsonData) as? [NSDictionary] {
                    for json in jsonResult {
                        let newitem = DataItem(id: json.value(forKey: "id") as! String, name: json.value(forKey: "name") as! String, image: json.value(forKey: "image") as? String)
                        result.append(newitem)
                    }
                }
            }
        } catch {
            print(error)
        }
        
        return result
    }
}

class DinoItem {
    let id: String
    let name: String
    let image: String
    let audio: String
    
    init(id: String, name: String, image: String, audio: String){
        self.id = id
        self.name = name
        self.image = image
        self.audio = audio
    }
    
    static func ReadFromJsonFile(filepath: String) -> [DinoItem] {
        var result: [DinoItem] = []
        
        do {
            let jsonData = try NSData(contentsOfFile: filepath, options: .mappedIfSafe) as Data
            if(jsonData.count > 0){
                if let jsonResult = try JSONSerialization.jsonObject(with: jsonData) as? [NSDictionary] {
                    for json in jsonResult {
                        let newitem = DinoItem(id: json.value(forKey: "id") as! String, name: json.value(forKey: "name") as! String, image: json.value(forKey: "image") as! String, audio: json.value(forKey: "audio") as! String)
                        result.append(newitem)
                    }
                }
            }
        } catch {
            print(error)
        }
        
        return result
    }
}








