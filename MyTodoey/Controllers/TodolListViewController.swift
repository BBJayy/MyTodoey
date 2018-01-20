//
//  ViewController.swift
//  MyTodoey
//
//  Created by Рома Сорока on 16.01.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [CellInfo]()
    var defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = item.isCheked ? .checkmark : .none
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].isCheked = !itemArray[indexPath.row].isCheked
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = itemArray[indexPath.row].isCheked ? .checkmark : .none
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    fileprivate func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
            
        } catch {
            print("Error encoding or writing data to plist \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let allert = UIAlertController(title: "Add new Todoey utem", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != "" {
                let cell = CellInfo()
                cell.name = textField.text!
                self.itemArray.append(cell)
                
                self.saveItems()
            }
        }
        allert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }
        allert.addAction(action)
        present(allert, animated: true, completion: nil)
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([CellInfo].self, from: data)
            }
            catch {
                print("Error loading data \(error)")
            }
        }
    }
    
}

