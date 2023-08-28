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
    
    //        Load data file path
            let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath!)
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
    
    fileprivate func saveItems() {
        //            Storing the new updated list to device using user defaults
        //            self.defaults.setValue(self.itemArray, forKey: "ToDoListArray")
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error in encoding item array")
        }
        
        
        //            reload the table view
        self.tableView.reloadData()
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
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error in decoding items")
            }
        }
    }
}

