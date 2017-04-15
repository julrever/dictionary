//
//  ViewController.swift
//  dictionary
//
//  Created by jul on 10.04.17.
//  Copyright © 2017 jul. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentCntrl: UISegmentedControl!
    var list : [JDictionary] = [JDictionary(word: "warum", translation: "почему", notes: ""),
                JDictionary(word: "wie geht", translation: "как дела", notes: ""),
                JDictionary(word: "fragen", translation: "спрашивать", notes: "666"),
                JDictionary(word: "lieben", translation: "любить", notes: "bffggf"),
                JDictionary(word: "lachen", translation: "смеяться", notes: ""),
                JDictionary(word: "wohnen", translation: "жить", notes: "kek"),
                JDictionary(word: "singen", translation: "петь", notes: ""),
                JDictionary(word: "tanzen", translation: "танцевать", notes: ""),
                JDictionary(word: "spielen", translation: "играть", notes: ""),
                JDictionary(word: "arbeiten", translation: "работать", notes: ""),
                JDictionary(word: "horen", translation: "слышать", notes: ""),
                JDictionary(word: "ich", translation: "я", notes: "fgbf"),
                JDictionary(word: "du", translation: "ты", notes: ""),
                JDictionary(word: "er", translation: "он", notes: ""),
                JDictionary(word: "sie", translation: "она", notes: ""),
                JDictionary(word: "wir", translation: "мы", notes: ""),
                JDictionary(word: "ihr", translation: "вы", notes: ""),
                JDictionary(word: "sagen", translation: "говорить", notes: "")]
    var isSearching = false
    var filteredList : [JDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        list = list.sorted(by: { $0.word.lowercased() < $1.word.lowercased() })
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newWord = NSEntityDescription.insertNewObject(forEntityName: "DBDictionary", into: context)
        newWord.setValue("warum", forKey: "word")
        newWord.setValue("почему", forKey: "translation")
        newWord.setValue("", forKey: "notes")
        do{
            try context.save()
            print("SAVE")
        } catch {
            // lalala
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBDictionary")
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]{
                    if let nword = result.value(forKey: "word") as? String{
                        print (nword)
                    }
                }
            }
        } catch{
            //kek
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (isSearching){
            return (filteredList.count)
        }
        return (list.count)
    }
    
    // ЗАПОЛНЕНИЕ ТАБЛИЦЫ
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        if (isSearching){
            cell.wordLabel.text = filteredList[indexPath.row].word
            cell.translateLabel.text = filteredList[indexPath.row].translation
        } else {
        cell.wordLabel.text = list[indexPath.row].word
        cell.translateLabel.text = list[indexPath.row].translation
        if (list[indexPath.row].notes != "")
        {
            cell.notesImage.image = #imageLiteral(resourceName: "note")
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
            cell.notesImage.addGestureRecognizer(tapGesture)
        }
        else {
            cell.notesImage.image = nil
        }
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        }
        else {
            isSearching = true
            filteredList = list.filter({$0.word.lowercased().contains((searchBar.text?.lowercased())!) || $0.translation.lowercased().contains((searchBar.text?.lowercased())!) })
            tableView.reloadData()
        }
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
            list = list.sorted(by: { $0.word.lowercased() < $1.word.lowercased() })
        } else if (segmentCntrl.selectedSegmentIndex == 1) {
            list = list.sorted(by: { $0.translation.lowercased() < $1.translation.lowercased()})
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
