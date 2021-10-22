//
//  SwiftUI_Requirements_and_SpecificationsApp.swift
//  SwiftUI Requirements and Specifications
//
//  Created by Larry Burris on 10/20/21.
//
import SwiftUI

@main
struct SwiftUI_Requirements_and_SpecificationsApp: App
{
    var body: some Scene
    {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        
        WindowGroup
        {
            //  Inject the viewContext into the ContentView
            ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
