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
    
    func loadFromList(with category:Catagory)->[List]? {
        let request:NSFetchRequest<List> = List.fetchRequest()

        if let title = category.name {
            request.predicate = NSPredicate.init(format: "parentCategory == %@", title)
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



