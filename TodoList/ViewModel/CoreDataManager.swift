//
//  CoreDataManager.swift
//  TodoList
//
//  Created by Raghuveer Beti on 20/02/21.
//  Copyright © 2021 Dhruva Beti. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveContext () {
        do {
            try context.save()
        } catch {
            print("Error:\(error)")
        }
    }
    
    func loadFromCataGory()->[Catagory]? {
        let request:NSFetchRequest<Catagory> = Catagory.fetchRequest()
        do {
            let categoryArr = try context.fetch(request)
            return categoryArr
        } catch {
            print("Error:\(error)")
            return nil
        }
    }
    
    func loadFromList(with category:Catagory, searchText:String?)->[List]? {
        let request:NSFetchRequest<List> = List.fetchRequest()

        if let title = category.name{
            
            let predicateOne = NSPredicate.init(format: "parentCategory.name MATCHES %@", title)
            request.predicate = predicateOne
            
            if let searchString = searchText  {
                let predicateTwo = NSPredicate.init(format: "title CONTAINS[cd] %@", searchString)
                let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predicateOne,predicateTwo])
                request.predicate = compoundPredicate
            }
            
        }
        
        do {
            let listArr = try context.fetch(request)
            return listArr
        } catch {
            print("Error:\(error)")
            return nil
        }
    }
}



