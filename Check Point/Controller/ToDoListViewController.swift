//
//  ToDoListViewController.swift
//  Check Point
//
//  Created by Lewis on 27/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    // Variables
    var itemArray = [Item]()
    var selectedCategory: Category? {
        didSet {
            //Loads items from the database
            loadItems()
        }
    }
    
    // Constants
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    
    
    //MARK: - Tableview Datasource Methods
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
    
    
    
    
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Sees if our model elements are true or false
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // Deletes items from the Database, then removes it from the array, make sure to delete from database first.
        // context.delete(itemArray[indexPath.row])
        // itemArray.remove(at: indexPath.row)
        
        // Saves the checkmark to our plist
        saveItems()
        
        // Deselects the cell so it doesn't stay highlighted
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // Local variable to store textField string from the closure.
        var textFieldString = UITextField()
        
        // This displays the top of the UIAlertAction and what it says ( added to the UIBarButtonItem)
        let alert = UIAlertController(title: "Add New Check List Item", message: "", preferredStyle: .alert)
        
        // This displays the writing in the button, at the bottom the alert, thus intialising the handler (closure)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // What will happen once the user clicks the add item button on our UIAlert
            let newItem = Item(context: self.context)
            newItem.title = textFieldString.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
    
    
    
    
    
    
    //MARK: - Model Manipulation Methods
    // Function to save the data
    func saveItems() {
        
        // Saves the data into the persistent container from the conext (staging area)
        do {
            try self.context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        // Reloads the tableView to make the newly added item appear
        tableView.reloadData()
    }
    
    
    
    // Function to load the data
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        // Specifies the data type, and in the <> markings is the enitity (this is coreDatas equivelent to a Class), it is a broad request as it retireves everything inside the persisent data contrainer. We have to speak to the context before we can fetch the persistent data in the container, so ItemArray equals 'try' using the current 'context' to 'fetch' this broad request that asks for every back, and once it does, save it in the itemArray, which is what is used to load up the tableView data source. This is implimented above as a default value in the parameters of the method
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
      
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)"   )
        }
        tableView.reloadData()
    }
    
    
    
}





//MARK: - Search bar methods
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            // ALways update my user interface on the .main thread
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
    
    
}


