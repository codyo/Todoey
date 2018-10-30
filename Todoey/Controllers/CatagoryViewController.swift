//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Cody on 10/26/18.
//  Copyright © 2018 Codyo. All rights reserved.
//

import UIKit
import RealmSwift

class CatagoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var catagories:Results<Catagory>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCatagories()

    }
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatagoryCell", for: indexPath)
        
        cell.textLabel?.text = catagories?[indexPath.row].name ?? "No Catagories added yet"
        
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCatagory = catagories?[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func save(catagory: Catagory){
        do{
            try realm.write{
                realm.add(catagory)
            }
        } catch{
            print("Error saving catagory: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCatagories(){
        catagories = realm.objects(Catagory.self)
        
        tableView.reloadData()
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Catagory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCatagory = Catagory()
            newCatagory.name = textField.text!
            
            self.save(catagory: newCatagory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new catagory"
        }
        
        present(alert, animated: true, completion: nil)
    }
   
}
