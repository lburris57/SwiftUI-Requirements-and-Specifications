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
    
    @State private var isPresented: Bool = false

    var requirement: Requirement

    func retrieveRequirementById()
    {
        requirementDetailViewModel.retrieveRequirementById(requirement.id)
    }

    var body: some View
    {
        Form
        {
            VStack(alignment: .leading, spacing: 8)
            {
                Section
                {
                    Group
                    {
                        HStack
                        {
                            Text("Requirement Id:").fontWeight(.bold)
                            Spacer()
                            Text("\(requirement.requirementId)")
                        }

                        VStack(alignment: .leading)
                        {
                            Text("Title:").fontWeight(.bold)
                            //Spacer()
                            Text("\(requirement.title)")
                        }

                        VStack(alignment: .leading)
                        {
                            Text("Description: ").fontWeight(.bold)
                            //Spacer()
                            Text("\(requirement.description)")
                        }

                        HStack
                        {
                            Text("Status: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirement.status)")
                        }

                        HStack
                        {
                            Text("Category: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirement.category)")
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
                            Text("\(requirement.priority)")
                        }

                        HStack
                        {
                            Text("Complexity: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirement.complexity)")
                        }

                        if(requirement.relatedDocuments != Constants.EMPTY_STRING)
                        {
                            HStack
                            {
                                Text("Related Documents: ").fontWeight(.bold)
                                Spacer()
                                Text("\(requirement.relatedDocuments)")
                            }
                        }

                        if(requirement.unitTestId != Constants.EMPTY_STRING)
                        {
                            HStack
                            {
                                Text("Unit Test Id: ").fontWeight(.bold)
                                Spacer()
                                Text("\(requirement.unitTestId)")
                            }
                        }

                        if(requirement.behavioralTestId != Constants.EMPTY_STRING)
                        {
                            HStack
                            {
                                Text("Behavioral Test Id: ").fontWeight(.bold)
                                Spacer()
                                Text("\(requirement.behavioralTestId)")
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
                            Text("Authored By: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirement.createdBy == Constants.EMPTY_STRING ? "Bubba" : requirement.createdBy)")
                        }
                        
                        HStack
                        {
                            Text("Last Updated: ").fontWeight(.bold)
                            Spacer()
                            Text("\(requirement.lastUpdated)")
                        }
                    }
                }

            }.navigationTitle("Requirement Details")
            .padding(8)
            .navigationBarItems(trailing: Button("Add Comment")
            {
                isPresented = true
            })
            .sheet(isPresented: $isPresented, onDismiss:
            {
                //requirementListViewModel.retrieveAllRequirements()
            }, content:
            {
                AddCommentView()
            })

            .onAppear(perform: {
                //requirementListViewModel.retrieveAllRequirements()
            })
            .onAppear(perform: retrieveRequirementById)
        }
    }
}
