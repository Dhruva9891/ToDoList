//
//  ListViewController.swift
//  TodoList
//
//  Created by Raghuveer Beti on 20/02/21.
//  Copyright © 2021 Dhruva Beti. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var listArr:[List]?
    var coreDataManager:CoreDataManager?
    var category:Catagory?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let title = category?.name {
            self.navigationItem.title = title
        }
        
        if let coreDataMgr = coreDataManager,let categoryObj = category {
            let list = List(context: coreDataMgr.context)
            list.title = "Apples"
            list.done = false
            list.parentCategory = categoryObj
            listArr = [list]
            coreDataMgr.saveContext()
        }
    
    }
    
    @IBAction func addNewListPressed(_ sender: UIBarButtonItem) {
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = "List"
        return cell
        
    }
}
