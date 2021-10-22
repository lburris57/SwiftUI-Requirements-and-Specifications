//
//  DBManager.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/20/21.
//
import Foundation
import Unrealm

class DBManager
{
    let today = Date()
    let realm = try! Realm()
    
//    func saveRequirement(_ requirement: Requirement)
//    {
//        do
//        {
//            try realm.write
//            {
//                realm.add(requirement)
//            }
//        }
//        catch
//        {
//            Log.error("Error saving requirement \(requirement.requirementId) to the database: \(error.localizedDescription)")
//        }
//        
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//    }
//    
//    func updateRequirement(_ requirement: Requirement)
//    {
//        do
//        {
//            try realm.write
//            {
//                realm.add(requirement, update: .modified)
//            }
//        }
//        catch
//        {
//            Log.error("Error updating requirement \(requirement.requirementId): \(error.localizedDescription)")
//        }
//        
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//    }
//    
//    func deleteRequirement(_ requirement: Requirement)
//    {
//        do
//        {
//            try realm.write
//            {
//                realm.delete(requirement)
//            }
//        }
//        catch
//        {
//            Log.error("Error deleting requirement \(requirement.requirementId): \(error.localizedDescription)")
//        }
//        
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//    }
//    
//    func retrieveAllRequirements() -> Results<Requirement>
//    {
//        return realm.objects(Requirement.self).sorted(byKeyPath: "requirementId", ascending: true)
//    }
//    
//    func retrieveRequirement(_ requirement: Requirement) -> Requirement?
//    {
//        return realm.objects(Requirement.self).filter("requirementId =='\(requirement.requirementId)'").first ?? nil
//    }
}
