//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData


class ToDoListViewController: UITableViewController {
    
    @IBOutlet weak var addAnItem: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemArray = [Item]()
    
//    To store the data we have to use user Defaults
    
    let defaults = UserDefaults.standard
    
    //        Load data file path
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(dataFilePath!)
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
    }

// MARK Table View Datasource Method
//  Create number of rows in table view cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

//    To add the values to table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray [indexPath.row].title
        
        if (itemArray[indexPath.row].done == true) {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
//    MARK Table View Delegate method
//    Click on cell in table view cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        if(itemArray[indexPath.row].done == true){
            itemArray[indexPath.row].done = false
        }else{
            itemArray[indexPath.row].done = true
        }
        
        self.saveItems()
        
//        Deselecte view cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        print("Button Pressed")
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            What will happen once user clicks Add Item Button on UI Alert

            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false

//          Add the item to array
            self . itemArray.append(newItem)
            self.saveItems()
        }
        
            alert.addTextField { AlertTextField in
            AlertTextField.placeholder = "Create new item"
            textField = AlertTextField
//            print(AlertTextField.text!)
        }
        
        alert.addAction(action)
        
       present(alert,animated: true,completion: nil)
    }
    func loadItems(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray =  try context.fetch(request)
        }catch{
            print("Error in fetching records\(error)")
        }
        
    }
    
//    Saving items to DB
    fileprivate func saveItems() {
        //            Storing the new updated list to device using user defaults
        //            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
        
        do{
            try context.save()
        }catch{
         print("Error in saving context\(error)")
        }
        
        
        //            reload the table view
        self.tableView.reloadData()
    }
}

