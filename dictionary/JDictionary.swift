//
//  Dictionary.swift
//  dictionary
//
//  Created by jul on 10.04.17.
//  Copyright © 2017 jul. All rights reserved.
//

import UIKit

class JDictionary: NSObject {
    var word: String = ""
    var translation: String = ""
    var notes: String = ""
    
    init(word: String, translation: String, notes: String){
        self.word = word
        self.translation = translation
        self.notes = notes
    }
    

}
