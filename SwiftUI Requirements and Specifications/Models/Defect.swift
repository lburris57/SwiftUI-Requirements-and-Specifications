//
//  Defect.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 2/12/22.
//
import Foundation
import CoreData

struct Defect: Identifiable
{
    let defectEntity: DefectEntity

    var id: NSManagedObjectID
    {
        return defectEntity.objectID
    }
    
    var defectId: String
    {
        return defectEntity.defectId ?? Constants.EMPTY_STRING
    }
    
    var user: UserEntity
    {
        return defectEntity.user ?? UserEntity()
    }

    var assignedToUserId: String
    {
        return defectEntity.assignedToUserId ?? Constants.EMPTY_STRING
    }

    var category: String
    {
        return defectEntity.category ?? Constants.EMPTY_STRING
    }
    
    var createdBy: String
    {
        return defectEntity.createdBy ?? Constants.EMPTY_STRING
    }

    var descriptionText: String
    {
        return defectEntity.descriptionText ?? Constants.EMPTY_STRING
    }
    
    var isCompleted: Bool
    {
        return defectEntity.isCompleted
    }

    var status: String
    {
        return defectEntity.status ?? Constants.EMPTY_STRING
    }
    
    var title: String
    {
        return defectEntity.title ?? Constants.EMPTY_STRING
    }

    var dateCreated: String
    {
        if let date = defectEntity.dateCreated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }

    var lastUpdated: String
    {
        if let date = defectEntity.lastUpdated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }
}
