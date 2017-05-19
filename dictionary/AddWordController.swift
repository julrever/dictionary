//
//  AddWordController.swift
//  dictionary
//
//  Created by jul on 10.04.17.
//  Copyright © 2017 jul. All rights reserved.
//

import UIKit
import CoreData

class AddWordController: UIViewController {
    @IBOutlet weak var wordTextfield: UITextField!
    @IBOutlet weak var translateTextfield: UITextField!
    @IBOutlet weak var notesTextField: UITextView!

    var currentWord : DBDictionary!
    var index : Int? = nil
    var newlist : [JDictionary] = []
    var managedObjectContext : NSManagedObjectContext!
    var list = [DBDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if (index != nil){
            wordTextfield.text = currentWord.word
            translateTextfield.text = currentWord.translation
            notesTextField.text = currentWord.notes
        }
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let wordRequest:NSFetchRequest<DBDictionary> = DBDictionary.fetchRequest()
        do {
            list = try managedObjectContext.fetch(wordRequest)
        } catch {
            print("couldn't load data")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func doneButton(_ sender: UIButton) {
        if (wordTextfield.text?.isEmpty)! || (translateTextfield.text?.isEmpty)! {
            let alert = UIAlertView()
            alert.title = "Заполните все поля"
            alert.addButton(withTitle: "ОК")
            alert.show()
        }
        else {
            if (index == nil)  {
                let newWord = DBDictionary(context: managedObjectContext)
                newWord.word = wordTextfield.text
                newWord.translation = translateTextfield.text
                newWord.notes = notesTextField.text
            } else {
                list[index!].word = wordTextfield.text
                list[index!].translation = translateTextfield.text
                list[index!].notes = notesTextField.text
            }
            
            do {
                try self.managedObjectContext.save()
            } catch {
                print("couldn't save data \(error.localizedDescription)")
            }
            performSegue(withIdentifier: "ready", sender: self)
        }
    }
}
