//
//  ViewController.swift
//  Let's Do This
//
//  Created by Evan Green on 1/4/18.
//  Copyright © 2018 Evan Green. All rights reserved.
//

import UIKit

class ToDoListController: UITableViewController {
    
    var itemArray = ["Find Pizza", "Eat Pizza", "Go to Gym"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // making the gray selector go away
        tableView.deselectRow(at: indexPath, animated: true)
        
        //get check mark to come up and go away by using an accessory
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //set up variable to catch the String added
        var newItem = UITextField()
        
        //want to get a ui alert to pop up and a textfield in it so that a person can add items
        let alert = UIAlertController(title: "Add To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user clicks the add item button on our UI alert
            self.itemArray.append(newItem.text!)
            
            //need to reload the data for the new item added
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            //set up alert textfield
            alertTextField.placeholder = "Create new item"
            newItem = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    


}
