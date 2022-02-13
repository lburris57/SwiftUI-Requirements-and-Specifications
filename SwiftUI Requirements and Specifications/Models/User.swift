//
//  User.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 2/12/22.
//
import Foundation
import CoreData

struct User: Identifiable
{
    let userEntity: UserEntity

    var id: NSManagedObjectID
    {
        return userEntity.objectID
    }

    var userId: String
    {
        return userEntity.userId ?? Constants.EMPTY_STRING
    }

    var userName: String
    {
        return userEntity.userName ?? Constants.EMPTY_STRING
    }

    var password: String
    {
        return userEntity.password ?? Constants.EMPTY_STRING
    }

    var dateCreated: String
    {
        if let date = userEntity.dateCreated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }

    var lastUpdated: String
    {
        if let date = userEntity.lastUpdated
        {
            return date.asFormattedString()
        }
        
        return Constants.EMPTY_STRING
    }
    
    var groups: [UserGroup]
    {
        if let groupSet = userEntity.groups
        {
            return groupSet.toArray()
        }

        return [UserGroup]()
    }
    
    var roles: [Role]
    {
        if let roleSet = userEntity.roles
        {
            return roleSet.toArray()
        }

        return [Role]()
    }
    
    var defects: [Defect]
    {
        if let defectSet = userEntity.defects
        {
            return defectSet.toArray()
        }

        return [Defect]()
    }
}
