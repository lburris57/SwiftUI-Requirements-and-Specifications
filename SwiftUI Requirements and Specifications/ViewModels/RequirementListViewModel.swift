//
//  RequirementListViewModel.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/22/21.
//
import Foundation
import CoreData

class RequirementListViewModel: ObservableObject
{
    @Published var requirements = [Requirement]()

    func retrieveAllRequirements()
    {
        self.requirements = RequirementEntity.all().map(Requirement.init)
    }

    func deleteRequirement(_ requirementEntity: RequirementEntity)
    {
        if let requirementEntity = RequirementEntity.byId(id: requirementEntity.objectID) as? RequirementEntity
        {
            requirementEntity.delete()
        }
    }
}
