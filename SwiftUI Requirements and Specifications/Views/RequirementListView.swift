//
//  RequirementListView.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/22/21.
//
import SwiftUI

struct RequirementListView: View
{
    @StateObject private var requirementListViewModel = RequirementListViewModel()

    @State private var isPresented: Bool = false

    private func deleteRequirement(at indexSet: IndexSet)
    {
        indexSet.forEach
        {
            index in

            let requirement = requirementListViewModel.requirements[index]

            // Delete the requirement
            requirementListViewModel.deleteRequirement(requirement.requirementEntity)

            // Refresh the requirements list in the view model
            requirementListViewModel.retrieveAllRequirements()
        }
    }

    var body: some View
    {
        List
        {
            //  Spin through the requirements list and generate
            //  a link to the detail view for each cell as well
            //  as provide a way for the user to delete the
            //  selected requirement
            ForEach(requirementListViewModel.requirements, id: \.id)
            {
                requirement in

                NavigationLink(destination: RequirementDetailView(requirement: Requirement(requirementEntity: requirement.requirementEntity)))
                {
                    RequirementCell(requirement: Requirement(requirementEntity: requirement.requirementEntity))
                }
            }
            .onDelete(perform: deleteRequirement)
        }
        .listStyle(.automatic)
        .navigationTitle("Requirements")
        .navigationBarItems(trailing: Button("Add Requirement")
        {
            isPresented = true
        })
        .fullScreenCover(isPresented: $isPresented, onDismiss:
        {
            requirementListViewModel.retrieveAllRequirements()
        }, content:
        {
            AddRequirementView()
        })
        .embedInNavigationView()
        .onAppear(perform:
        {
            requirementListViewModel.retrieveAllRequirements()
        })
    }
}

struct RequirementListView_Previews: PreviewProvider
{
    static var previews: some View
    {
        RequirementListView()
    }
}

struct RequirementCell: View
{
    let requirement: Requirement
    
    //  Returns the color based on the priority
    private func styleForPriority(_ value: String) -> Color
    {
        let priority = Priority(rawValue: value)
        
        switch priority
        {
            case .low:
                return Color.green
            case .medium:
                return Color.orange
            case .high:
                return Color.red
            default:
                return Color.blue
        }
    }

    var body: some View
    {
        HStack
        {
            VStack(alignment: .leading, spacing: 5)
            {
                HStack
                {
                    Circle()
                        .fill(styleForPriority(requirement.priority))
                    .frame(width: 15, height: 15)
                    
                    Text("\(requirement.requirementId) \(requirement.title)")
                        .fontWeight(.bold)
                }
                
                Text("Category: \(requirement.category)")
                    .font(.caption)
                
                Text("Status: \(requirement.status)")
                    .font(.caption)

                Text("Last updated: \(requirement.lastUpdated)")
                    .font(.caption2)
            }
            
            Spacer()
        }
    }
}

extension View
{
    func embedInNavigationView() -> some View
    {
        NavigationView { self }
    }
}
