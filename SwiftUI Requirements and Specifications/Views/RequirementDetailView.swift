//
//  RequirementDetailView.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/22/21.
//
import CoreData
import SwiftUI

struct RequirementDetailView: View
{
    @StateObject private var requirementDetailViewModel = RequirementDetailViewModel()

    var requirementViewModel: RequirementViewModel

    func retrieveRequirementById()
    {
        requirementDetailViewModel.retrieveRequirementById(requirementViewModel.id)
    }

    var body: some View
    {
        Form
        {
            VStack(alignment: .leading, spacing: 5)
            {
                Section
                {
                    Group
                    {
                        HStack
                        {
                            Text("Requirement Id:").fontWeight(.bold)
                            Spacer()
                            Text("\(requirementViewModel.requirementId)")
                        }

                        HStack
                        {
                            Text("Title:").fontWeight(.bold)
                            Spacer()
                            Text("\(requirementViewModel.title)")
                        }

                        HStack
                        {
                            Text("Description: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirementViewModel.description)")
                        }

                        HStack
                        {
                            Text("Status: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirementViewModel.status)")
                        }

                        HStack
                        {
                            Text("Category: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirementViewModel.category)")
                        }
                    }
                }

                Section
                {
                    Group
                    {
                        HStack
                        {
                            Text("Priority: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirementViewModel.priority)")
                        }

                        HStack
                        {
                            Text("Complexity: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirementViewModel.complexity)")
                        }

                        if(requirementViewModel.relatedDocuments != Constants.EMPTY_STRING)
                        {
                            HStack
                            {
                                Text("Related Documents: ").fontWeight(.bold)
                                Spacer()
                                Text("\(requirementViewModel.relatedDocuments)")
                            }
                        }

                        if(requirementViewModel.unitTestId != Constants.EMPTY_STRING)
                        {
                            HStack
                            {
                                Text("Unit Test Id: ").fontWeight(.bold)
                                Spacer()
                                Text("\(requirementViewModel.unitTestId)")
                            }
                        }

                        if(requirementViewModel.behavioralTestId != Constants.EMPTY_STRING)
                        {
                            HStack
                            {
                                Text("Behavioral Test Id: ").fontWeight(.bold)
                                Spacer()
                                Text("\(requirementViewModel.behavioralTestId)")
                            }
                        }
                    }
                }
                
                Section
                {
                    Group
                    {
                        HStack
                        {
                            Text("Created By: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirementViewModel.createdBy == Constants.EMPTY_STRING ? "Bubba" : requirementViewModel.createdBy)")
                        }
                        
                        HStack
                        {
                            Text("Last Updated: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirementViewModel.lastUpdated)")
                        }
                    }
                }

            }.navigationTitle("Requirement Details")
            .padding(8)
            .onAppear(perform: retrieveRequirementById)
        }
    }
}
