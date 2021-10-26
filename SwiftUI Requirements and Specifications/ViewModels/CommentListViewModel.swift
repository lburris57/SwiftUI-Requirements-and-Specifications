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
    
    func getCommentsByRequirement(vm: RequirementViewModel)
    {
//        DispatchQueue.main.async
//        {
            //self.comments = Comment.getCommentsByRequirementId(requirementId: vm.id).map(CommentViewModel.init)
//        }
    }
}
