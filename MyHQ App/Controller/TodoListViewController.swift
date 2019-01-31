//
//  ViewController.swift
//  MyHQ App
//
//  Created by MAC on 29/01/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemsArray = [TodoData]()
    
    var defaults = UserDefaults.standard
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//
//        let newItem = TodoData()
//            newItem.title = "Buy another car"
//            itemsArray.append(newItem)
//
//        let newItem2 = TodoData()
//            newItem2.title = "Get land at lekki"
//            itemsArray.append(newItem2)
//
//        let newItem3 = TodoData()
//            newItem3.title = "Purchase another software"
//            itemsArray.append(newItem3)
//
//        if let items = defaults.array(forKey: "ToDoLists") as? [TodoData]{
//            itemsArray = items
//        }
        
        
        fetchData()
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
      
        cell.textLabel?.text = itemsArray[indexPath.row].title
        
        cell.accessoryType = itemsArray[indexPath.row].isDone ==  true ? .checkmark : .none
        
//
//        if itemsArray[indexPath.row].isDone == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemsArray[indexPath.row].isDone = !itemsArray[indexPath.row].isDone
    
        savedataMethod()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //This is a textfield in the UIAlertController
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add itemt to To-Do List", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            let newItem = TodoData()
            newItem.title = textField.text!
            
            self.itemsArray.append(newItem)
            self.savedataMethod()
           
        }
        
        alert.addTextField { (alertTextName) in
            alertTextName.placeholder = "Enter Item Name"
            textField = alertTextName
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func savedataMethod() {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
        } catch{
            print("Error message is:  \(error)")
        }
        
        // self.defaults.set(self.itemsArray, forKey: "ToDoLists")
        self.tableView.reloadData()
    }
    
    func fetchData(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            self.itemsArray = try decoder.decode([TodoData].self, from: data)
            } catch {
                print(error)
            }
            
        }
    }
    
}

