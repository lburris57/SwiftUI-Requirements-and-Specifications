//
//  Role.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 2/12/22.
//

import Foundation
import CoreData

struct Role: Identifiable
{
    let roleEntity: RoleEntity

    var id: NSManagedObjectID
    {
        return roleEntity.objectID
    }

    var roleId: String
    {
        return roleEntity.roleId ?? Constants.EMPTY_STRING
    }

    var roleName: String
    {
        return roleEntity.roleName ?? Constants.EMPTY_STRING
    }

    var dateCreated: String
    {
        if let date = roleEntity.dateCreated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }

    var lastUpdated: String
    {
        if let date = roleEntity.lastUpdated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }
    
    var users: [User]
    {
        if let userSet = roleEntity.users
        {
            return userSet.toArray()
        }

        return [User]()
    }
}
