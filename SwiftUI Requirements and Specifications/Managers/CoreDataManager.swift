//
//  CoreDataManager.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/21/21.
//
import CoreData
import Foundation

class CoreDataManager
{
    let persistentContainer: NSPersistentContainer

    static let shared: CoreDataManager = CoreDataManager()

    private init()
    {
        persistentContainer = NSPersistentContainer(name: "RequirementSpec")

        persistentContainer.loadPersistentStores
        {
            _, error in

            if let error = error
            {
                Log.error("Unable to initialize Core Data: \(error.localizedDescription)")
            }
        }
    }

    func getRequirementById(id: NSManagedObjectID) -> RequirementSpecification?
    {
        do
        {
            return try persistentContainer.viewContext.existingObject(with: id) as? RequirementSpecification
        }
        catch
        {
            Log.error("Unable to retrieve requirement with id \(id): \(error.localizedDescription)")
            return nil
        }
    }

    func deleteRequirement(_ requirement: RequirementSpecification)
    {
        persistentContainer.viewContext.delete(requirement)

        do
        {
            try persistentContainer.viewContext.save()
        }
        catch
        {
            persistentContainer.viewContext.rollback()
            
            Log.error("Failed to delete requirement \(requirement.title!): \(error.localizedDescription).  Rolling back changes...")
        }
    }

    func retrieveAllRequirements() -> [RequirementSpecification]
    {
        let fetchRequest: NSFetchRequest<RequirementSpecification> = RequirementSpecification.fetchRequest()

        do
        {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch
        {
            return []
        }
    }

    func save(_ requirement: RequirementSpecification)
    {
        do
        {
            try persistentContainer.viewContext.save()
        }
        catch
        {
            persistentContainer.viewContext.rollback()
            
            Log.error("Error saving requirement \(requirement.requirementId!) - \(requirement.title!): \(error.localizedDescription)")
        }
    }
}
