//
//  ViewController.swift
//  TodoList
//
//  Created by Raghuveer Beti on 20/02/21.
//  Copyright © 2021 Dhruva Beti. All rights reserved.
//

import UIKit

class CatagoryViewController: UITableViewController {
    
    var categoryName:String?
    var categoryArr:[Catagory]?
    var coreDataManager = CoreDataManager()
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(filePath)
        
        let category = Catagory(context: coreDataManager.context)
        category.name = "Shopping"
        categoryArr = [category]
        coreDataManager.saveContext()
        
    }
    
    
    @IBAction func addNewCategoryPressed(_ sender: UIBarButtonItem) {
        
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
            categoryName = categoryObj.name
        }
        performSegue(withIdentifier: "toListScreen", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListScreen" {
            let listVC = segue.destination as! ListViewController
            listVC.titleText = categoryName
        }
    }
}

