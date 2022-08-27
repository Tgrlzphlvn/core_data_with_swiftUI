//
//  CoreDataManager.swift
//  core-data-with-swiftUI
//
//  Created by Tuğrul Özpehlivan on 27.08.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistantContainer : NSPersistentContainer
    
    init() {
        persistantContainer = NSPersistentContainer(name: "core_data_with_swiftUI")
        persistantContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store Filed\(error.localizedDescription)")
            }
        }
    }
    
    func getNotes() -> [Notes] {
        let fetchRequest : NSFetchRequest<Notes> = Notes.fetchRequest()
        
        do {
            return try persistantContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func save(title : String, note : String) {
        let notes = Notes(context: persistantContainer.viewContext)
        notes.title = title
        notes.note = note
        
        do {
            try persistantContainer.viewContext.save()
        } catch {
            print("Failed to save movie \(error.localizedDescription)")
        }
    }
    
    func delete(notes : Notes) {
        persistantContainer.viewContext.delete(notes)
        
        do {
            try persistantContainer.viewContext.save()
        } catch {
            persistantContainer.viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}
