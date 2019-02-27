//
//  ToDoListViewController.swift
//  Check Point
//
//  Created by Lewis on 27/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    // Variables
    var itemArray = [Item]()
    
    // Constants
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Make a cake"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Bake Bread"
        itemArray.append(newItem3)
        
//         Reloads the user defaults
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Creates how many rows should be in the tableView, in this case how many elements are in the itemArray
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Creates the cell for the UITableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // Populates the cell with the text for the current row (indexPath.row)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
     // Checks to see if the item.done is true or not, if it is then it sets it to .checkmark, if it's false it's set to .none
        cell.accessoryType = item.done ? .checkmark : .none
        
        // Returns the cell to display
        return cell
    }
    
    
    
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    // Sees if our model elements are true or false
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        
        
        // Deselects the cell so it doesn't stay highlighted
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // Local variable to store textField string from the closure.
        var textFieldString = UITextField()
        
        // This displays the top of the UIAlertAction and what it says ( added to the UIBarButtonItem)
        let alert = UIAlertController(title: "Add New Check List Item", message: "", preferredStyle: .alert)
        
        // This displays the writing in the button, at the bottom the alert, thus intialising the handler (closure)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // What will happen once the user clicks the add item button on our UIAlert
            let newItem = Item()
            newItem.title = textFieldString.text!
            self.itemArray.append(newItem)
            
            // Saves the itemArray to the userDefaults (Doesn't load it back when you terminate the app), saves to the pList file, eveything going in has to be a key value pair. 
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            // Reloads the tableView to make the newly added item appear
            self.tableView.reloadData()
        }
        
        // Adds a text field to the UIAlert, sets its placeholder
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textFieldString = alertTextField
        }
        
        // Adds the action to the alert.
        alert.addAction(action)
        
        // This presents the alert when the button is pressed
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
}

