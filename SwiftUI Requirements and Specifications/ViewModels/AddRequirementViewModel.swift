//
//  AddRequirementViewModel.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/24/21.
//
import Foundation
import CoreData

class AddRequirementViewModel: ObservableObject
{
    func saveRequirement(requirement: Requirement)
    {
        if let requirementEntity = RequirementEntity.byId(id: requirement.requirementEntity.objectID) as? RequirementEntity
        {
            requirementEntity.save()
        }
    }
}
