//
//  CatagoryViewController.swift
//  Let's Do This
//
//  Created by Evan Green on 1/16/18.
//  Copyright © 2018 Evan Green. All rights reserved.
//

import UIKit
import CoreData

class CatagoryViewController: UITableViewController {
    
    var catagoryArray = [Catagory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCatagory()

    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        
        let catagory = catagoryArray[indexPath.row]
        
        cell.textLabel?.text = catagory.name
        
        saveCatagory()
        
        return cell
    }
    
    
    //MARK: - Data Manipulation Methods
    
    //save data
    
    func saveCatagory() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    //load data
    func loadCatagory(with request: NSFetchRequest<Catagory> = Catagory.fetchRequest()) {
        do {
            catagoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context\(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - set up the add button pressed IB action

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //set up variable to catch the String added
        var textField = UITextField()
        
        
        //want to get a ui alert to pop up and a textfield in it so that a person can add items
        let alert = UIAlertController(title: "Add To Do Catagory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Catagory", style: .default) { (action) in
            //what will happen once user clicks the add item button on our UI alert
            
            let newCatagory = Catagory(context: self.context)
            newCatagory.name = textField.text!
            self.catagoryArray.append(newCatagory)
            
            //save array to user defaults
            self.saveCatagory()
            
            //need to reload the data for the new item added
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            //set up alert textfield
            alertTextField.placeholder = "Create new catagory"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = catagoryArray[indexPath.row]
        }
    }
    
}
