//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    @IBOutlet weak var addAnItem: UIBarButtonItem!
    var itemArray = [Item]()
    
//    To store the data we have to use user Defaults
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
// Do any additional setup after loading the view.
        
//        Calling stored user defaults to load the existing data
//        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
//            itemArray = items
//        }
        
//        Add Items to Class
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Buy Eggos"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Destroy Demogorgon"
        itemArray.append(newItem2)
        
        
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
        
//        Reloading the table based on new selection
        tableView.reloadData()
        
//        Deselecte view cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        print("Button Pressed")
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            What will happen once user clicks Add Item Button on UI Alert
//            print("Add Item Pressed\(textField.text)")
            
        let newItem = Item()
            newItem.title = textField.text!
            
//            Add the item to array
            self . itemArray.append(newItem)
            
//            Storing the new updated list to device using user defaults
            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
            
//            reload the table view
            self.tableView.reloadData()
            

            
        }
        alert.addTextField { AlertTextField in
            AlertTextField.placeholder = "Create new item"
            textField = AlertTextField
//            print(AlertTextField.text!)
        }
        
        alert.addAction(action)
        
       present(alert,animated: true,completion: nil)
    }
}

