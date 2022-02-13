//
//  Test.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 2/12/22.
//
import Foundation
import CoreData

struct Test: Identifiable
{
    let testEntity: TestEntity

    var id: NSManagedObjectID
    {
        return testEntity.objectID
    }
    
    var testId: String
    {
        return testEntity.testId ?? Constants.EMPTY_STRING
    }

    var title: String
    {
        return testEntity.title ?? Constants.EMPTY_STRING
    }

    var descriptionText: String
    {
        return testEntity.descriptionText ?? Constants.EMPTY_STRING
    }

    var dateCreated: String
    {
        if let date = testEntity.dateCreated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }

    var lastUpdated: String
    {
        if let date = testEntity.lastUpdated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }
}
