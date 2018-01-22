//
//  CategoryTableViewController.swift
//  MyTodoey
//
//  Created by Рома Сорока on 21.01.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

        loadCategoryArray()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added yet"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selecetedCategory = categoryArray?[indexPath.row]
        }
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let allert = UIAlertController(title: "Add new Todoey category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if textField.text != "" {
                let newCategory = Category()
                newCategory.name = textField.text!
//                self.categoryArray.append(newCategory)
                
                self.save(category: newCategory)
            }
        }
        allert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        allert.addAction(action)
        present(allert, animated: true, completion: nil)
    }
    
    func loadCategoryArray() {
        categoryArray = realm.objects(Category.self)
//        let request: NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//            categoryArray = try context.fetch(request)
//        }
//        catch {
//            print("Error fetching from context \(error)")
//        }
        tableView.reloadData()
    }
    
    
    func save(category: Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }

    
}
