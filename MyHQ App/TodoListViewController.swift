//
//  ViewController.swift
//  MyHQ App
//
//  Created by MAC on 29/01/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemsArray = ["Collect like terms","Visit Investors","Buy from aliexpress"]
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
    }
    
    //MARK Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoListCell")
        cell.textLabel?.text = itemsArray[indexPath.row]
        return cell
    }
    
    
    //MARK TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print(indexPath.row)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
          tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("add button pressed")
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add itemt to To-Do List", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            self.itemsArray.append(textField.text!)
            self.defaults.set(self.itemsArray, forKey: "ToDoLists")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextName) in
            alertTextName.placeholder = "Enter Item Name"
            textField = alertTextName
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

