//
//  Comment+Extensions.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/24/21.
//
import Foundation
import CoreData

extension CommentEntity: BaseModel
{
    static func getCommentsByRequirementId(requirementId: NSManagedObjectID) -> [CommentEntity]
    {
        let request: NSFetchRequest<CommentEntity> = CommentEntity.fetchRequest()
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
    
    static func deleteComment(commentEntity: CommentEntity)
    {
        commentEntity.delete()
    }
}
