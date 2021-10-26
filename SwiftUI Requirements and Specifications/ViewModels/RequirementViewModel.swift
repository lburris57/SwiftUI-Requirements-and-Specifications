//
//  RequirementViewModel.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/22/21.
//
import Foundation
import CoreData

struct RequirementViewModel
{
    func asFormattedString(_ date: Date) -> String
    {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter.string(from: date)
    }
    
    let requirement: RequirementSpecification

    var id: NSManagedObjectID
    {
        return requirement.objectID
    }

    var requirementId: String
    {
        return requirement.requirementId ?? Constants.EMPTY_STRING
    }

    var title: String
    {
        return requirement.title ?? Constants.EMPTY_STRING
    }

    var description: String
    {
        return requirement.descriptionText ?? Constants.EMPTY_STRING
    }
    
    var functionalArea: String
    {
        return requirement.functionalArea ?? Constants.EMPTY_STRING
    }

    var category: String
    {
        return requirement.category ?? Constants.EMPTY_STRING
    }

    var complexity: String
    {
        return requirement.complexity ?? Constants.EMPTY_STRING
    }

    var priority: String
    {
        return requirement.priority ?? Constants.EMPTY_STRING
    }

    var status: String
    {
        return requirement.status ?? Constants.EMPTY_STRING
    }

    var relatedDocuments: String
    {
        return requirement.relatedDocuments ?? Constants.EMPTY_STRING
    }

    var unitTestId: String
    {
        return requirement.unitTestId ?? Constants.EMPTY_STRING
    }

    var behavioralTestId: String
    {
        return requirement.behavioralTestId ?? Constants.EMPTY_STRING
    }

    var isCompleted: Bool
    {
        return requirement.isCompleted
    }
    
    var createdBy: String
    {
        return requirement.createdBy ?? Constants.EMPTY_STRING
    }

    var dateCreated: String
    {
        if let date = requirement.dateCreated
        {
            return asFormattedString(date)
        }
        
        return Constants.EMPTY_STRING
    }

    var lastUpdated: String
    {
        if let date = requirement.lastUpdated
        {
            return asFormattedString(date)
        }
        
        return Constants.EMPTY_STRING
    }
}
