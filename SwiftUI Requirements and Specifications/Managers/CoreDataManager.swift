//
//  CoreDataManager.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/21/21.
//
import Foundation
import CoreData

class CoreDataManager
{
    let persistentContainer: NSPersistentContainer
    
    static let shared: CoreDataManager = CoreDataManager()
    
    private init()
    {
        persistentContainer = NSPersistentContainer(name: "RequirementSpec")
        
        persistentContainer.loadPersistentStores
        {
            description, error in
            
            if let error = error
            {
                Log.error("Unable to initialize Core Data: \(error.localizedDescription)")
            }
        }
    }
}
