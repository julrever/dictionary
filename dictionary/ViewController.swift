//
//  ViewController.swift
//  dictionary
//
//  Created by jul on 10.04.17.
//  Copyright © 2017 jul. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentCntrl: UISegmentedControl!
    var list : [JDictionary] = [JDictionary(word: "warum", translation: "почему", pass: 2, notes: ""),
                JDictionary(word: "wie geht", translation: "как дела", pass: 2, notes: ""),
                JDictionary(word: "fragen", translation: "спрашивать", pass: 2, notes: "666"),
                JDictionary(word: "lieben", translation: "любить", pass: 2, notes: "bffggf"),
                JDictionary(word: "lachen", translation: "смеяться", pass: 2, notes: ""),
                JDictionary(word: "wohnen", translation: "жить", pass: 2, notes: "kek"),
                JDictionary(word: "singen", translation: "петь", pass: 2, notes: ""),
                JDictionary(word: "tanzen", translation: "танцевать", pass: 2, notes: ""),
                JDictionary(word: "spielen", translation: "играть", pass: 2, notes: ""),
                JDictionary(word: "arbeiten", translation: "работать", pass: 2, notes: ""),
                JDictionary(word: "horen", translation: "слышать", pass: 2, notes: ""),
                JDictionary(word: "ich", translation: "я", pass: 2, notes: "fgbf"),
                JDictionary(word: "du", translation: "ты", pass: 2, notes: ""),
                JDictionary(word: "er", translation: "он", pass: 2, notes: ""),
                JDictionary(word: "sie", translation: "она", pass: 2, notes: ""),
                JDictionary(word: "wir", translation: "мы", pass: 2, notes: ""),
                JDictionary(word: "ihr", translation: "вы", pass: 2, notes: ""),
                JDictionary(word: "sagen", translation: "говорить", pass: 2, notes: "")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        list = list.sorted(by: { $0.word < $1.word })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (list.count)
    }
    
    // ЗАПОЛНЕНИЕ ТАБЛИЦЫ
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.wordLabel.text = list[indexPath.row].word
        cell.translateLabel.text = list[indexPath.row].translation
        if (list[indexPath.row].notes != "")
        {
            cell.notesImage.image = #imageLiteral(resourceName: "note")
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
            cell.notesImage.addGestureRecognizer(tapGesture)
        }
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "editCell", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // УДАЛЕНИЕ СТРОКИ ПО СВАЙПУ
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tappedMe(sender : UITapGestureRecognizer)
    {
        let tapLocation = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: tapLocation)

        let alert = UIAlertView()
        alert.title = list[indexPath!.row].notes
        alert.addButton(withTitle: "ОК")
        alert.show()
    }
    
    // ПЕРЕДАЧА ДАННЫХ В ДРУГИЕ КОНТРОЛЛЕРЫ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editCell"){                    // ОТПРАВКА ВЫБРАННОГО СЛОВА ДЛЯ РЕДАКТИРОВАНИЯ
            let indexPath = tableView.indexPath(for: sender as! TableViewCell)
            let i = indexPath?.row
            let guest = segue.destination as! AddWordController
            if (segmentCntrl.selectedSegmentIndex == 1) {
                guest.langGe = false
            }
            guest.index = i
            guest.currentWord = list[i!]
        } else if (segue.identifier == "repeat"){               // ОТПРАВКА ПЕРЕМЕШАННОГО МАССИВА ДЛЯ ПОВТОРЕНИЯ
            let guest = segue.destination as! RepeatController
            guest.list = self.list.shuffled()
        }
    }
    
    // СОРТИРОВКА ПО ЯЗЫКУ ПРИ НАЖАТИИ НА SegmentedControl
    @IBAction func segmentPushed(_ sender: UISegmentedControl) {
        if (segmentCntrl.selectedSegmentIndex == 0){
            list = list.sorted(by: { $0.word < $1.word })
        } else if (segmentCntrl.selectedSegmentIndex == 1) {
            list = list.sorted(by: { $0.translation < $1.translation})
        }
        tableView.reloadData()
    }
}

// СКРЫТИЕ КЛАВИАТУРЫ ПО НАЖАТИЮ ВНЕ
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
