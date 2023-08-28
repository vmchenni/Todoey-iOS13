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
    var itemArray = ["Find Mike","Buy Eggs", "Destroy Demogorgon","Sample"]
    
//    To store the data we have to use user Defaults
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        Calling stored user defaults to load the existing data
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = items
        }
    }

// MARK Table View Datasource Method
//  Create number of rows in table view cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

//    To add the values to table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray [indexPath.row]
        
        return cell
    }
    
//    MARK Table View Delegate method
//    Click on cell in table view cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
//        Check if there is a check box
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
//  Remove checkbox if exist
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
//            Add a check box if don't exist
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            
//            Add the item to array
            self . itemArray.append(textField.text!)
            
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

