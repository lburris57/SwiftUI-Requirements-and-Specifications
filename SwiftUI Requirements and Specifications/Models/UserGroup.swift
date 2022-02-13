//
//  UserGroup.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 2/12/22.
//
import Foundation
import CoreData

struct UserGroup: Identifiable
{
    let groupEntity: UserGroupEntity

    var id: NSManagedObjectID
    {
        return groupEntity.objectID
    }

    var groupId: String
    {
        return groupEntity.groupId ?? Constants.EMPTY_STRING
    }

    var groupName: String
    {
        return groupEntity.groupName ?? Constants.EMPTY_STRING
    }

    var dateCreated: String
    {
        if let date = groupEntity.dateCreated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }

    var lastUpdated: String
    {
        if let date = groupEntity.lastUpdated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }
    
    var users: [User]
    {
        if let userSet = groupEntity.users
        {
            return userSet.toArray()
        }

        return [User]()
    }
}
