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
    // Creates the path to where we are gonna save our newly made plist.
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath!)
        
        // Loads the items from the plist
        loadItems()
        
        
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
        
        // Saves the checkmark to our plist
        saveItems()
        
        
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
            self.saveItems()
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
    
    
    //MARK - Model Manipulation Methods
    
    
    // Function to save the data
    func saveItems() {
        // Encodes the data to the file path specified in dataFilePath and saves it as a plist in the form of an array. It encodes the data here into data that is stored as a plist
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error in encoding itemArray \(error)")
        }
        
        // Reloads the tableView to make the newly added item appear
        self.tableView.reloadData()
    }
    
    // Function to load the data, this decoder decodes the plist data to be usable again in swift data
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error \(error)")
            }
        }
    }
    
    
    
    
    
    
    
    
    
}

