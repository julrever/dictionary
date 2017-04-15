//
//  AddWordController.swift
//  dictionary
//
//  Created by jul on 10.04.17.
//  Copyright © 2017 jul. All rights reserved.
//

import UIKit

class AddWordController: UIViewController {
    @IBOutlet weak var wordTextfield: UITextField!
    @IBOutlet weak var translateTextfield: UITextField!
    @IBOutlet weak var notesTextField: UITextView!

    var currentWord = JDictionary(word: "", translation: "", notes: "")
    var index : Int? = nil
    var newlist : [JDictionary] = []
    var langGe : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if (index != nil){
            wordTextfield.text = currentWord.word
            translateTextfield.text = currentWord.translation
            notesTextField.text = currentWord.notes
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // НАЖАТИЕ КНОПКИ "ГОТОВО"
    @IBAction func doneButton(_ sender: UIButton) {
        if (wordTextfield.text?.isEmpty)! || (translateTextfield.text?.isEmpty)! {
            let alert = UIAlertView()
            alert.title = "Заполните все поля"
            alert.addButton(withTitle: "ОК")
            alert.show()                                        // ЕСЛИ ПОЛЯ НЕ ЗАПОЛНЕНЫ - ПРЕДПРЕЖДЕНИЕ
        }
        else {
            performSegue(withIdentifier: "ready", sender: self)     // ИНАЧЕ - ВЫПОЛНИТЬ ПЕРЕХОД
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ready"){
            let guest = segue.destination as! ViewController
            let tmpDict = JDictionary(word: wordTextfield.text!, translation: translateTextfield.text!, notes: notesTextField.text!)
            if (index != nil){
                if (langGe) {
                    guest.list = guest.list.sorted(by: { $0.word.lowercased() < $1.word.lowercased() })
                } else {
                    guest.list = guest.list.sorted(by: { $0.translation.lowercased() < $1.translation.lowercased() })
                }
                guest.list[index!] = tmpDict
            } else {
            guest.list.append(tmpDict)
            }
        }
    }

}
