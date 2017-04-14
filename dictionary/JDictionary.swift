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
    var pass: Int = 0
    var notes: String = ""
    
    init(word: String, translation: String, pass: Int, notes: String){
        self.word = word
        self.translation = translation
        self.pass = pass
        self.notes = notes
    }
    

}
