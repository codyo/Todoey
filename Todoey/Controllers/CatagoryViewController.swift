//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Cody on 10/26/18.
//  Copyright © 2018 Codyo. All rights reserved.
//

import UIKit
import CoreData

class CatagoryViewController: UITableViewController {
    
    var catagories = [Catagory]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCatagories()

    }
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        
        cell.textLabel?.text = catagories[indexPath.row].name
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCatagory = catagories[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCatagories(){
        do{
            try context.save()
        } catch{
            print("Error saving catagory: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCatagories(){
        let request:NSFetchRequest<Catagory> = Catagory.fetchRequest()
        
        do {
            catagories = try context.fetch(request)
        } catch {
            print("Error loading catagories \(error)")
        }
        
        tableView.reloadData()
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Catagory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCatagory = Catagory(context: self.context)
            newCatagory.name = textField.text!
            
            self.catagories.append(newCatagory)
            
            self.saveCatagories()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new catagory"
        }
        
        present(alert, animated: true, completion: nil)
    }
   
}
