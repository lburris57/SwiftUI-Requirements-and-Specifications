//
//  RequirementsAndSpecificationsApp.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/20/21.
//
import SwiftUI

@main
struct RequirementsAndSpecificationsApp: App
{
    var body: some Scene
    {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        
        WindowGroup
        {
            //  Inject the viewContext into the RequirementListView
            RequirementListView().environment(\.managedObjectContext, persistentContainer.viewContext)
            .onAppear
            {
                UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            }
        }
    }
}
