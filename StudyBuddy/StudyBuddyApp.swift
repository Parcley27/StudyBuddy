//
//  StudyBuddyApp.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 2024-06-21.
//

import SwiftUI
//import SwiftData

@main

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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        // This would pass along the local storage information to the window group and then into the content view if we were using it
        //.modelContainer(sharedModelContainer)
    }
}
