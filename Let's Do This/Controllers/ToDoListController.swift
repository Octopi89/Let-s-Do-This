//
//  ViewController.swift
//  Let's Do This
//
//  Created by Evan Green on 1/4/18.
//  Copyright © 2018 Evan Green. All rights reserved.
//

import UIKit

class ToDoListController: UITableViewController {
    
    var itemArray = [Item]()
    
    //Mark - set up user defaults
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // making the gray selector go away
        tableView.deselectRow(at: indexPath, animated: true)
        
        //get check mark to come up and go away by using an accessory
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
    }
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //set up variable to catch the String added
        var textField = UITextField()
        
        
        //want to get a ui alert to pop up and a textfield in it so that a person can add items
        let alert = UIAlertController(title: "Add To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user clicks the add item button on our UI alert
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //save array to user defaults
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            //need to reload the data for the new item added
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            //set up alert textfield
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }

}
