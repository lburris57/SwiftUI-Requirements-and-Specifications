//
//  Comment+Extensions.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/24/21.
//
import Foundation
import CoreData

extension Comment
{
    static func getCommentsByRequirementId(requirementId: NSManagedObjectID) -> [Comment]
    {
        let request: NSFetchRequest<Comment> = Comment.fetchRequest()
        request.predicate = NSPredicate(format: "requirement = %@", requirementId)
        
        do
        {
            return try CoreDataManager.shared.persistentContainer.viewContext.fetch(request)
        }
        catch
        {
            return []
        }
    }
}
