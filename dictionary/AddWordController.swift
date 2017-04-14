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
    @IBOutlet weak var repeatSwitch: UISwitch!

    var currentWord = JDictionary(word: "", translation: "", pass: 2, notes: "")
    var index : Int? = nil
    var newlist : [JDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if (index != nil){
            wordTextfield.text = currentWord.word
            translateTextfield.text = currentWord.translation
            if (currentWord.notes != "") {
                notesTextField.text = currentWord.notes
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        if (wordTextfield.text?.isEmpty)! || (translateTextfield.text?.isEmpty)! {
            let alert = UIAlertView()
            alert.title = "Заполните все поля"
            alert.addButton(withTitle: "ОК")
            alert.show()
        }
        performSegue(withIdentifier: "ready", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ready"){
            let guest = segue.destination as! ViewController
            let tmpDict = JDictionary(word: wordTextfield.text!, translation: translateTextfield.text!, pass: 2, notes: "")
            guest.list.append(tmpDict)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
