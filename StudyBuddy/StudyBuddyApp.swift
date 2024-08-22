//
//  StudyBuddyApp.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 2024-06-21.
//

// Import SwiftUI for any future UI elements, and to hold the ContentView in the body
import SwiftUI
// SwiftData is a super simple way of storing persistant data on device between app sessions
// An app will only last so long in memory before being cleared even if not by the user
// We don't need it for now, but it could be used to store user information or offline stuff later
//import SwiftData

// Assigns this file as the main app file
// Everything runs out of the @Main file, and contains the first view loaded when the app is opened
@main
// Declares StudyBuddyApp as the main "App" struct
struct StudyBuddyApp: App {
    // How to read/write to local storage
    // Not used now, but it might be useful later so I'll leave it in for now
    /*
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    */
    
    // The body of the view contains everything the user will be able to see
    // It's a scene, instead of a view because it has to fill the entire screen (I think)
    var body: some Scene {
        WindowGroup {
            // Calls the ContentView struct
            // This isn't the name of the file where the view is stored, it's just the name of the view
            
            ContentView(/* Any paramaters or inputs would likely go in here*/)
            
        }
        // This would pass along the local storage information to the window group and then into the content view if we were using it
        //.modelContainer(sharedModelContainer)
    }
}
