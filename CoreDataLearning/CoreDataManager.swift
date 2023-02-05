//
//  CoreDataManager.swift
//  CoreDataLearning
//
//  Created by Sergei Poluboiarinov on 05.02.2023.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("We couldn't load our Core data: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("We saved our Data!!!")
        } catch let error {
            print("We couldn't save our Core Data: \(error.localizedDescription)")
        }
    }
    
    func addItem(name: String, price: Double, pc: Int16, context: NSManagedObjectContext) {
        let newItem = Item(context: context)
        newItem.name = name
        newItem.price = price
        newItem.pc = pc
        save(context: context)
    }
    
    func editItem(item: Item, name: String, price: Double, pc: Int16, context: NSManagedObjectContext) {
        item.name = name
        item.price = price
        item.pc = pc
        save(context: context)
    }
}
