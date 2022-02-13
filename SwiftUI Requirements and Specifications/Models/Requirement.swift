//
//  Requirement.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/22/21.
//
import Foundation
import CoreData

struct Requirement: Identifiable
{
    let requirementEntity: RequirementEntity

    var id: NSManagedObjectID
    {
        return requirementEntity.objectID
    }

    var requirementId: String
    {
        return requirementEntity.requirementId ?? Constants.EMPTY_STRING
    }

    var title: String
    {
        return requirementEntity.title ?? Constants.EMPTY_STRING
    }

    var description: String
    {
        return requirementEntity.descriptionText ?? Constants.EMPTY_STRING
    }
    
    var functionalArea: String
    {
        return requirementEntity.functionalArea ?? Constants.EMPTY_STRING
    }

    var category: String
    {
        return requirementEntity.category ?? Constants.EMPTY_STRING
    }

    var complexity: String
    {
        return requirementEntity.complexity ?? Constants.EMPTY_STRING
    }

    var priority: String
    {
        return requirementEntity.priority ?? Constants.EMPTY_STRING
    }

    var status: String
    {
        return requirementEntity.status ?? Constants.EMPTY_STRING
    }

    var relatedDocuments: String
    {
        return requirementEntity.relatedDocuments ?? Constants.EMPTY_STRING
    }

    var unitTestId: String
    {
        return requirementEntity.unitTestId ?? Constants.EMPTY_STRING
    }

    var behavioralTestId: String
    {
        return requirementEntity.behavioralTestId ?? Constants.EMPTY_STRING
    }

    var isCompleted: Bool
    {
        return requirementEntity.isCompleted
    }
    
    var createdBy: String
    {
        return requirementEntity.createdBy ?? Constants.EMPTY_STRING
    }

    var dateCreated: String
    {
        if let date = requirementEntity.dateCreated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }

    var lastUpdated: String
    {
        if let date = requirementEntity.lastUpdated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }
    
    var comments: [Comment]
    {
        if let commentSet = requirementEntity.comments
        {
            return commentSet.toArray()
        }

        return [Comment]()
    }
}

extension Date
{
    func asFormattedString() -> String
    {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter.string(from: self)
    }
}
