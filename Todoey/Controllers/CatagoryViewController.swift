//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Cody on 10/26/18.
//  Copyright © 2018 Codyo. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CatagoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var catagories:Results<Catagory>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCatagories()
        
        tableView.separatorStyle = .none
        
//        print("color sample: \(UIColor.randomFlat.hexValue())")

    }
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let catagory = catagories?[indexPath.row] {
        
            cell.textLabel?.text = catagory.name
            
            guard let catagoryColor = UIColor(hexString: catagory.backgroundColor) else { fatalError() }
        
            cell.backgroundColor = catagoryColor
            
            cell.textLabel?.textColor = ContrastColorOf(catagoryColor, returnFlat: true)
        }
        
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
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let catagoryForDeletion = self.catagories?[indexPath.row]{
            do {
                try self.realm.write{
                    self.realm.delete(catagoryForDeletion)
                }
            } catch {
                print("Error deleting catagory, \(error)")
            }

        }
    }
    
    
    
    //MARK: - Add New Catagories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Catagory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCatagory = Catagory()
            newCatagory.name = textField.text!
            newCatagory.backgroundColor = UIColor.randomFlat.hexValue()
            
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



