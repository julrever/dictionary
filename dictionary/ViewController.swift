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
    var isSearching = false
    var filteredList : [DBDictionary] = []
    var list = [DBDictionary]()
    var managedObjectContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = list.sorted(by: { ($0.word?.lowercased())! < ($1.word?.lowercased())! })
        self.hideKeyboardWhenTappedAround()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.loadData()
        
    }
    
    
    func loadData(){
        let wordRequest:NSFetchRequest<DBDictionary> = DBDictionary.fetchRequest()
        do {
            list = try managedObjectContext.fetch(wordRequest)
            self.tableView.reloadData()
        } catch {
            print("couldn't load data")
        }
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
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            managedObjectContext.delete(list[indexPath.row])
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try self.managedObjectContext.save()
            } catch {
                print("couldn't delete data \(error.localizedDescription)")
            }
        }
    }
    
    
    func tappedMe(sender : UITapGestureRecognizer)
    {
        let tapLocation = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: tapLocation)

        let alert = UIAlertView()
        alert.title = list[indexPath!.row].notes!
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
            filteredList = list.filter({$0.word!.lowercased().contains((searchBar.text?.lowercased())!) || $0.translation!.lowercased().contains((searchBar.text?.lowercased())!) })
            tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editCell"){
            let indexPath = tableView.indexPath(for: sender as! TableViewCell)
            let i = indexPath?.row
            let guest = segue.destination as! AddWordController
            guest.index = i
            guest.currentWord = list[i!]
        } else if (segue.identifier == "repeat"){
            let guest = segue.destination as! RepeatController
            guest.list = self.list.shuffled()
        }
    }
    
    
    @IBAction func segmentPushed(_ sender: UISegmentedControl) {
        if (segmentCntrl.selectedSegmentIndex == 0){
            list = list.sorted(by: { ($0.word?.lowercased())! < ($1.word?.lowercased())! })
        } else if (segmentCntrl.selectedSegmentIndex == 1) {
            list = list.sorted(by: { ($0.translation?.lowercased())! < ($1.translation?.lowercased())!})
        }
        tableView.reloadData()
    }
}


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
