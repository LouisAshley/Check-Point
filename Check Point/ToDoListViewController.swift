//
//  ToDoListViewController.swift
//  Check Point
//
//  Created by Lewis on 27/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Andy", "Buy Eggs", "Buy Pokemon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.textLabel?.text = itemArray[indexPath.row]
        // Returns the cell to display
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Gives the cell that was selected a checkmark (Accessory), and also removes the check mark if it already has one.
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
             tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
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
            self.itemArray.append(textFieldString.text!)
            
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

