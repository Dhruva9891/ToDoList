//
//  ListViewController.swift
//  TodoList
//
//  Created by Raghuveer Beti on 20/02/21.
//  Copyright © 2021 Dhruva Beti. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController,UITextFieldDelegate {
    
    var listArr:[List]?
    var coreDataManager = CoreDataManager()
    var category:Catagory?
    var alertAction:UIAlertAction?
    var alertTextField:UITextField?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = category?.name {
            self.navigationItem.title = title
        }
        
        if let array = coreDataManager.loadFromList() {
            self.listArr = array
        }

    }
    
    @IBAction func addNewListPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController.init(title: "List", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.delegate = self
            self.alertTextField = textField
        }
        let action = UIAlertAction.init(title: "Add List", style: .default) { (alertView) in
            if let categoryObj = self.category, let enteredText = self.alertTextField?.text {
                let list = List(context: self.coreDataManager.context)
                list.title = enteredText
                list.done = false
                list.parentCategory = categoryObj
                self.coreDataManager.saveContext()
                if let array = self.coreDataManager.loadFromList() {
                    self.listArr = array
                    self.tableView.reloadData()
                }
            }
        }
        alert.addAction(action)
        action.isEnabled = false
        alertAction = action
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
        return listArr?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        if let list = listArr?[indexPath.row]{
            cell.textLabel?.text = list.title
        }
        
        return cell
        
    }
}
