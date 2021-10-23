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
    @Published var requirementViewModel: RequirementViewModel?

    private var coreDataManager = CoreDataManager.shared

    func retrieveRequirementById(_ id: NSManagedObjectID)
    {
        let requirement = coreDataManager.getRequirementById(id: id)

        DispatchQueue.main.async
        {
            self.requirementViewModel = requirement.map(RequirementViewModel.init)
        }
    }

    func saveRequirement(requirementViewModel: RequirementViewModel)
    {
        let requirement = CoreDataManager.shared.getRequirementById(id: requirementViewModel.id)

        if let requirement = requirement
        {
            CoreDataManager.shared.save(requirement)
        }
    }
}
