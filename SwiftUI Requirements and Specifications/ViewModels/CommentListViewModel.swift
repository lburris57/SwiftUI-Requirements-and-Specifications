//
//  CommentListViewModel.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/24/21.
//
import Foundation
import CoreData

class CommentListViewModel: ObservableObject
{
    @Published var comments = [Comment]()
    
    private var coreDataManager = CoreDataManager.shared
    
    func getCommentsByRequirementId(_ id: NSManagedObjectID)
    {
        self.comments = CommentEntity.getCommentsByRequirementId(requirementId: id).map(Comment.init)
    }
}
