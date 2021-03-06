//
//  AddRequirementView.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/22/21.
//
import Foundation
import SwiftUI

enum Category: String, Identifiable, CaseIterable, Hashable
{
    var id: UUID
    {
        return UUID()
    }

    case database = "Database"
    case model = "Model"
    case viewModel = "View Model"
    case view = "View"
    case utils = "Utils"
    case manager = "Manager"
    case helper = "Helper"
    case propertyWrapper = "Property Wrapper"
    case refactor = "Refactor"
}

extension Category
{
    var title: String
    {
        switch self
        {
            case .database:
                return "Database"
            case .model:
                return "Model"
            case .viewModel:
                return "View Model"
            case .view:
                return "View"
            case .utils:
                return "Utils"
            case .manager:
                return "Manager"
            case .helper:
                return "Helper"
            case .propertyWrapper:
                return "Property Wrapper"
            case .refactor:
                return "Refactor"
        }
    }
}

enum Complexity: String, Identifiable, CaseIterable, Hashable
{
    var id: UUID
    {
        return UUID()
    }

    case trivial = "Trivial"
    case medium = "Medium"
    case complex = "Complex"
}

extension Complexity
{
    var title: String
    {
        switch self
        {
            case .trivial:
                return "Trivial"
            case .medium:
                return "Medium"
            case .complex:
                return "Complex"
        }
    }
}

enum Status: String, Identifiable, CaseIterable, Hashable
{
    var id: UUID
    {
        return UUID()
    }

    case awaitingAssignment = "Awaiting Assignment"
    case inProgress = "In Progress"
    case completed = "Completed"
    case deferred = "Deferred"
}

extension Status
{
    var title: String
    {
        switch self
        {
            case .awaitingAssignment:
                return "Awaiting Assignment"
            case .inProgress:
                return "In Progress"
            case .completed:
                return "Completed"
            case .deferred:
                return "Deferred"
        }
    }
}

enum Priority: String, Identifiable, CaseIterable, Hashable
{
    var id: UUID
    {
        return UUID()
    }

    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case enhancement = "Enhancement"
}

extension Priority
{
    var title: String
    {
        switch self
        {
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
            case .enhancement:
                return "Enhancement"
        }
    }
}

enum CreatedBy: String, Identifiable, CaseIterable, Hashable
{
    var id: UUID
    {
        return UUID()
    }

    case admin = "Admin"
    case businessAnalyst = "Business Analyst"
    case validationTeam = "Validation Team"
    case developmentTeam = "Development Team"
}

extension CreatedBy
{
    var title: String
    {
        switch self
        {
            case .admin:
                return "Admin"
            case .businessAnalyst:
                return "Business Analyst"
            case .validationTeam:
                return "Validation Team"
            case .developmentTeam:
                return "Development Team"
        }
    }
}

struct AddRequirementView: View
{
    //  Get the managedObjectContext from the environment which we saved in the app file
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var requirementId = Constants.EMPTY_STRING
    @State private var title = Constants.EMPTY_STRING
    @State private var description = Constants.EMPTY_STRING
    @State private var functionalArea = Constants.EMPTY_STRING
    @State private var selectedCreatedBy: CreatedBy = .businessAnalyst
    @State private var selectedCategory: Category = .model
    @State private var selectedComplexity: Complexity = .medium
    @State private var selectedPriority: Priority = .medium
    @State private var selectedStatus: Status = .awaitingAssignment
    @State private var relatedDocuments = Constants.EMPTY_STRING
    @State private var unitTestId = Constants.EMPTY_STRING
    @State private var behavioralTestId = Constants.EMPTY_STRING
    @State private var isCompleted = false
    
    //  This fetch request retrieves all the requirements in the database
    //  and assigns them to the allRequirements variable which is of type
    //  FetchedResults<RequirementSpecification>
    @FetchRequest(entity: RequirementEntity.entity(),
                sortDescriptors: [NSSortDescriptor(key: "priority", ascending: false)])
                private var allRequirements: FetchedResults<RequirementEntity>
    
    
    //  Creates a new RequirementSpecification object, populates the values and saves to the database
    private func saveRequirement()
    {
        do
        {
            let requirement = RequirementEntity(context: viewContext)
            
            requirement.requirementId = requirementId
            requirement.title = title
            requirement.functionalArea = functionalArea
            requirement.descriptionText = description
            requirement.dateCreated = Date()
            requirement.lastUpdated = Date()
            requirement.createdBy = selectedCreatedBy.rawValue
            requirement.status = selectedStatus.rawValue
            requirement.category = selectedCategory.rawValue
            requirement.complexity = selectedComplexity.rawValue
            requirement.priority = selectedPriority.rawValue
            requirement.relatedDocuments = relatedDocuments
            requirement.unitTestId = unitTestId
            requirement.behavioralTestId = behavioralTestId
            requirement.isCompleted = isCompleted
            
            try viewContext.save()
            
            Log.info("Successfully saved requirement \(requirementId) - \(title)")
        }
        catch
        {
            Log.error("Error saving requirement \(requirementId) - \(title): \(error.localizedDescription)")
        }
        
    }
    
    //  Resets all the fields to the default values
    private func clearAllFields()
    {
        requirementId = Constants.EMPTY_STRING
        title = Constants.EMPTY_STRING
        functionalArea = Constants.EMPTY_STRING
        description = Constants.EMPTY_STRING
        selectedCreatedBy = .businessAnalyst
        selectedCategory = .model
        selectedComplexity = .medium
        selectedPriority = .medium
        selectedStatus = .awaitingAssignment
        relatedDocuments = Constants.EMPTY_STRING
        unitTestId = Constants.EMPTY_STRING
        behavioralTestId = Constants.EMPTY_STRING
    }
    
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
    
    //  Evaluates whether the required fields are populated
    private func evaluateFields() -> Bool
    {
        if requirementId == Constants.EMPTY_STRING || title == Constants.EMPTY_STRING || description == Constants.EMPTY_STRING
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    //  Toggles the isCompleted value of the requirement and saves the updated value
    private func updateIsCompleted(_ requirementEntity: RequirementEntity)
    {
        requirementEntity.isCompleted.toggle()
        requirementEntity.lastUpdated = Date()
        
        do
        {
            try viewContext.save()
            
            Log.info("Successfully updated requirement \(requirementEntity.requirementId!) - \(requirementEntity.title!) isCompleted value to \(requirementEntity.isCompleted)")
        }
        catch
        {
            Log.error("Error updating requirement \(requirementEntity.requirementId!) - \(requirementEntity.title!): \(error.localizedDescription)")
        }
    }
    
    //  Deletes the requirement from the database based on the position in the allRequirements array
    private func deleteRequirement(at offsets: IndexSet)
    {
        offsets.forEach
        {
            index in
            
            let requirement = allRequirements[index]
            
            let requirementId = requirement.requirementId
            let title = requirement.title
            
            viewContext.delete(requirement)
            
            do
            {
                try viewContext.save()
                
                Log.info("Successfully deleted requirement \(requirementId!) - \(title!)")
            }
            catch
            {
                Log.error("Error deleting requirement \(requirementId!) - \(title!): \(error.localizedDescription)")
            }
            
        }
    }

    var body: some View
    {
        NavigationView
        {
            VStack(alignment: .leading)
            {
                VStack(alignment: .leading, spacing: 10)
                {
                    TextField("Enter requirement id", text: $requirementId)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    TextField("Enter title", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
//                    TextField("Enter functional area", text: $functionalArea)
//                        .textFieldStyle(.roundedBorder)
//                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 5)
                    {
                        Text(" Enter Description:")
                            .foregroundColor(Color.secondary)
                            .padding(.horizontal)
                        
                        TextEditor(text: $description)
                        .lineLimit(6)
                        .border(.secondary, width: 1)
                        .padding(.horizontal)
                    }
                    
                    HStack
                    {
                        Text(" Select Author:")
                            .foregroundColor(Color.secondary)
                        
                        Picker("Created By", selection: $selectedCreatedBy)
                        {
                            ForEach(CreatedBy.allCases)
                            {
                                createdBy in
                                Text(createdBy.title).tag(createdBy)
                            }
                        }.pickerStyle(.menu)
                    }.padding(.horizontal)
                    
                    HStack
                    {
                        Text(" Select Status:")
                            .foregroundColor(Color.secondary)
                        
                        Picker("Status", selection: $selectedStatus)
                        {
                            ForEach(Status.allCases)
                            {
                                status in
                                Text(status.title).tag(status)
                            }
                        }.pickerStyle(.menu)
                    }.padding(.horizontal)

                    HStack
                    {
                        Text(" Select Category:")
                            .foregroundColor(Color.secondary)
                        
                        Picker(Constants.EMPTY_STRING, selection: $selectedCategory)
                        {
                            ForEach(Category.allCases)
                            {
                                category in
                                Text(category.title).tag(category)
                            }
                        }
                        .pickerStyle(.menu)
                        .labelsHidden()
                    }.padding(.horizontal)
                    
                    HStack
                    {
                        Text(" Select Priority:")
                            .foregroundColor(Color.secondary)
                        
                        Picker("Priority", selection: $selectedPriority)
                        {
                            ForEach(Priority.allCases)
                            {
                                priority in
                                Text(priority.title).tag(priority)
                            }
                        }.pickerStyle(.menu)
                    }.padding(.horizontal)

                    VStack(alignment: .leading)
                    {
                        Text(" Select Complexity:").foregroundColor(Color.secondary)
                        
                        Picker("Complexity", selection: $selectedComplexity)
                        {
                            ForEach(Complexity.allCases)
                            {
                                complexity in
                                Text(complexity.title).tag(complexity)
                            }
                        }.pickerStyle(.segmented)
                    }.padding(.horizontal)
                    
                    Group
                    {
//                                TextField("Enter any related documents", text: $relatedDocuments)
//                                    .textFieldStyle(.roundedBorder)
//                                    .padding(.horizontal)
//
//                                TextField("Enter unit test id", text: $unitTestId)
//                                    .textFieldStyle(.roundedBorder)
//                                    .padding(.horizontal)
//
//                                TextField("Enter behavioral test id", text: $behavioralTestId)
//                                    .textFieldStyle(.roundedBorder)
//                                    .padding(.horizontal)

                        Spacer()
                        
                        Button("Save Requirement Information")
                        {
                            saveRequirement()
                            clearAllFields()
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue).opacity(!evaluateFields() ? 0.6 : 1)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .shadow(color: .black, radius: 2.0, x: 2.0, y: 2.0)
                        .disabled(!evaluateFields())
                        
                        Spacer()
                    }
                        
                }.navigationTitle("Add Requirement")
                .navigationBarItems(trailing: Button("Cancel")
                {
                    presentationMode.wrappedValue.dismiss()
                })
                .padding(8)
                .background(.ultraThinMaterial)
            }
        }
    }
}

struct AddRequirementView_Previews: PreviewProvider
{
    static var previews: some View
    {
        AddRequirementView()
    }
}
