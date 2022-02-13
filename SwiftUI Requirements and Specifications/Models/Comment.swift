//
//  Comment.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/24/21.
//
import Foundation
import CoreData

struct Comment: Identifiable
{
    let commentEntity: CommentEntity

    var id: NSManagedObjectID
    {
        return commentEntity.objectID
    }

    var title: String
    {
        return commentEntity.title ?? Constants.EMPTY_STRING
    }

    var text: String
    {
        return commentEntity.commentText ?? Constants.EMPTY_STRING
    }

    var author: String
    {
        return commentEntity.author ?? Constants.EMPTY_STRING
    }

    var requirement: RequirementEntity
    {
        return commentEntity.requirement ?? RequirementEntity()
    }
    
    var dateCreated: String
    {
        if let date = commentEntity.dateCreated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }

    var lastUpdated: String
    {
        if let date = commentEntity.lastUpdated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }
}

extension NSSet
{
    func toArray<T>() -> [T]
    {
        let array = map({ $0 as! T })
        return array
    }
}
