//
//  ContentView.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/20/21.
//
import Foundation
import SwiftUI
import Network

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

struct ContentView: View
{
    //  Get the managedObjectContext from the environment which we saved in the app file
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var requirementId = Constants.EMPTY_STRING
    @State private var title = Constants.EMPTY_STRING
    @State private var description = Constants.EMPTY_STRING
    @State private var createdBy = Constants.EMPTY_STRING
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
    @FetchRequest(entity: RequirementSpecification.entity(),
                sortDescriptors: [NSSortDescriptor(key: "priority", ascending: false)])
                private var allRequirements: FetchedResults<RequirementSpecification>
    
    
    //  Creates a new RequirementSpecification object, populates the values and saves to the database
    private func saveRequirement()
    {
        do
        {
            let requirement = RequirementSpecification(context: viewContext)
            
            requirement.requirementId = requirementId
            requirement.title = title
            requirement.descriptionText = description
            requirement.createdBy = createdBy
            requirement.dateCreated = Date()
            requirement.lastUpdated = Date()
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
        description = Constants.EMPTY_STRING
        createdBy = Constants.EMPTY_STRING
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
    private func updateIsCompleted(_ requirement: RequirementSpecification)
    {
        requirement.isCompleted.toggle()
        requirement.lastUpdated = Date()
        
        do
        {
            try viewContext.save()
            
            Log.info("Successfully updated requirement \(requirement.requirementId!) - \(requirement.title!) isCompleted value to \(requirement.isCompleted)")
        }
        catch
        {
            Log.error("Error updating requirement \(requirement.requirementId!) - \(requirement.title!): \(error.localizedDescription)")
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
                    
                    TextField("Enter description", text: $description)
                        .lineLimit(4)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    TextField("Enter user creating requirement", text: $createdBy)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    HStack
                    {
                        Text("Select Status:")
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
                        Text("Select Category:")
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
                        Text("Select Priority:")
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
                        Text("Select Complexity:")
                            .foregroundColor(Color.secondary)
                        
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

                        Button("Save Requirement Information")
                        {
                            saveRequirement()
                            clearAllFields()
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue).opacity(!evaluateFields() ? 0.6 : 1)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .shadow(color: .black, radius: 2.0, x: 2.0, y: 2.0)
                        .disabled(!evaluateFields())
                        
                        List
                        {
                            ForEach(allRequirements)
                            {
                                requirement in
                                
                                HStack
                                {
                                    Circle()
                                        .fill(styleForPriority(requirement.priority!))
                                        .frame(width: 15, height: 15)
                                    
                                    Text(requirement.title ?? "No title")
                                    
                                    Spacer()
                                    
                                    // Displays a green checkmark or a red
                                    // pen and pencil ellipsis depending on
                                    // the isCompleted value which is toggled
                                    // in the updateIsCompleted() function
                                    requirement.isCompleted ?
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                        .onTapGesture
                                        {
                                           updateIsCompleted(requirement)
                                        }
                                    :
                                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                        .foregroundColor(.red)
                                        .onTapGesture
                                        {
                                           updateIsCompleted(requirement)
                                        }
                                }
                            }.onDelete(perform: deleteRequirement)
                        }

                        Spacer()
                    }
                        
                    }.navigationTitle("Add Requirement")
                    .padding(8)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
