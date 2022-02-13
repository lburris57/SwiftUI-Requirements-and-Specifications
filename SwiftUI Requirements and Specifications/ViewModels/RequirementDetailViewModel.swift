//
//  RequirementDetailViewModel.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/22/21.
//
import Foundation
import CoreData

class RequirementDetailViewModel: ObservableObject
{
    @Published var requirement: Requirement?
    @Published var comments = [Comment]()

    func retrieveRequirementById(_ id: NSManagedObjectID)
    {
        if let requirementEntity = RequirementEntity.byId(id: id) as? RequirementEntity
        {
            self.requirement = Requirement(requirementEntity: requirementEntity)
        }
    }
    
    func retrieveCommentsByRequirementId(_ id: NSManagedObjectID)
    {
        self.comments = CommentEntity.getCommentsByRequirementId(requirementId: id).map(Comment.init)
    }

    func deleteRequirement(_ requirementEntity: RequirementEntity)
    {
        if let requirementEntity = RequirementEntity.byId(id: requirementEntity.objectID) as? RequirementEntity
        {
            requirementEntity.delete()
        }
    }
    
    func deleteComment(_ commentEntity: CommentEntity)
    {
        if let commentEntity = CommentEntity.byId(id: commentEntity.objectID) as? CommentEntity
        {
            commentEntity.delete()
        }
    }
}
