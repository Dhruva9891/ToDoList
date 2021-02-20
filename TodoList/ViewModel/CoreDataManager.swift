//
//  CoreDataManager.swift
//  TodoList
//
//  Created by Raghuveer Beti on 20/02/21.
//  Copyright © 2021 Dhruva Beti. All rights reserved.
//

import Foundation
import UIKit

class CoreDataManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveContext () {
        do {
            try context.save()
        } catch {
            print("Error:\(error)")
        }
    }
}



