//
//  RepeatController.swift
//  dictionary
//
//  Created by jul on 10.04.17.
//  Copyright © 2017 jul. All rights reserved.
//

import UIKit

class RepeatController: UIViewController {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translationTextfield: UITextField!
    var list : [JDictionary] = []
    var current : Int = 0
    let alert = UIAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        wordLabel.text = list[current].word
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func missButton(_ sender: UIButton) {
        alert.title = "Правильный перевод: " + list[current].translation
        alert.addButton(withTitle: "ОК")
        alert.show()
        current += 1
        if (current == list.count) {
            alert.title = "Слова для повторения закончились :)"
            alert.addButton(withTitle: "ОК")
            alert.show()
        } else {
        wordLabel.text = list[current].word
        }
    }
    
    @IBAction func readyButton(_ sender: UIButton) {
        if (translationTextfield.text == list[current].translation){
            current += 1
            if (current == list.count) {
                alert.title = "Слова для повторения закончились :)"
                alert.addButton(withTitle: "ОК")
                alert.show()
            } else {
            wordLabel.text = list[current].word
            translationTextfield.text = ""
            }
        } else {
            alert.title = "Неверно. Попробуйте еще раз :)"
            alert.addButton(withTitle: "ОК")
            alert.show()
            translationTextfield.text = ""
        }
    }
    
    

}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
