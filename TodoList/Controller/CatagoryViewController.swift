//
//  ViewController.swift
//  TodoList
//
//  Created by Raghuveer Beti on 20/02/21.
//  Copyright © 2021 Dhruva Beti. All rights reserved.
//

import UIKit

class CatagoryViewController: UITableViewController,UITextFieldDelegate {
    
    var category:Catagory?
    var categoryArr:[Catagory]?
    var coreDataManager = CoreDataManager()
    var alertAction:UIAlertAction?
    var alertTextField:UITextField?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let array = self.coreDataManager.loadFromCataGory() {
            categoryArr = array
        }
        
    }
    
    
    @IBAction func addNewCategoryPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController.init(title: "Category", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.delegate = self
            self.alertTextField = textField
        }
        let action = UIAlertAction.init(title: "Add Category", style: .default) { (action) in
            if let textEntered = self.alertTextField?.text{
                let category = Catagory(context: self.coreDataManager.context)
                category.name = textEntered
                self.coreDataManager.saveContext()
                if let array = self.coreDataManager.loadFromCataGory() {
                    self.categoryArr = array
                    self.tableView.reloadData()
                }
            }
        }
        self.alertAction = action
        action.isEnabled = false
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TextField delegate methods
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let action = alertAction {
            if let count = textField.text?.count {
                action.isEnabled = count > 0 ? true : false
            }
        }
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArr?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catagoryCell", for: indexPath)
        if let categoryObj = categoryArr?[indexPath.row] {
            cell.textLabel?.text = categoryObj.name
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let categoryObj = categoryArr?[indexPath.row] {
            category = categoryObj
        }
        performSegue(withIdentifier: "toListScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListScreen" {
            let listVC = segue.destination as! ListViewController
            listVC.category = category
            listVC.coreDataManager = coreDataManager
        }
    }
}

