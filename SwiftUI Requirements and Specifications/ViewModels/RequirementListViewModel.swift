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
    @Published var requirements = [RequirementViewModel]()

    private var coreDataManager = CoreDataManager.shared

    func retrieveAllRequirements()
    {
        let requirements = coreDataManager.retrieveAllRequirements()

        DispatchQueue.main.async
        {
            self.requirements = requirements.map(RequirementViewModel.init)
        }
    }

    func deleteRequirement(requirementViewModel: RequirementViewModel)
    {
        let requirement = CoreDataManager.shared.getRequirementById(id: requirementViewModel.id)

        if let requirement = requirement
        {
            CoreDataManager.shared.deleteRequirement(requirement)
        }
    }
}
