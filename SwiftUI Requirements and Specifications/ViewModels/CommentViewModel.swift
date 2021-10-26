//
//  CommentViewModel.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/24/21.
//
import Foundation
import CoreData

struct CommentViewModel
{
    func asFormattedString(_ date: Date) -> String
    {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter.string(from: date)
    }
    
    let comment: Comment

    var id: NSManagedObjectID
    {
        return requirement.objectID
    }

    var title: String
    {
        return comment.title ?? Constants.EMPTY_STRING
    }

    var text: String
    {
        return comment.commentText ?? Constants.EMPTY_STRING
    }

    var author: String
    {
        return comment.author ?? Constants.EMPTY_STRING
    }

    var requirement: RequirementSpecification
    {
        return comment.requirement ?? RequirementSpecification()
    }

    var dateCreated: String
    {
        if let date = comment.dateCreated
        {
            return asFormattedString(date)
        }
        
        return Constants.EMPTY_STRING
    }

    var lastUpdated: String
    {
        if let date = comment.lastUpdated
        {
            return asFormattedString(date)
        }
        
        return Constants.EMPTY_STRING
    }
}
