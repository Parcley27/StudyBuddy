//
//  ContentView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 2024-06-21.
//

import SwiftUI
// We would use this if we wanted to store/access app data with this view
//import SwiftData

struct GreenView: View {
    var body: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            
            Text("GreenView Content")
            
        }
    }
}

struct ContentView: View {
    @State var selectedTab: String = "home"
    
    @State var userProfileData: ProfileData = ProfileData.profile
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    TabItemView("Home", "house.fill")
                    
                }
                .tag("home")
            
            GreenView()
                .tabItem {
                    TabItemView("Explore", "map.fill")
                    
                }
                .tag("green")
            
            ProfileView(profileData: $userProfileData)
                .tabItem {
                    TabItemView("Profile", "person.fill")
                    
                }
                .tag("profile")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
