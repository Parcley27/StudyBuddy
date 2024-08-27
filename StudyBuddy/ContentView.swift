//
//  ContentView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 2024-06-21.
//

import SwiftUI
// We would use this if we wanted to store/access app data with this view
//import SwiftData

struct RedView: View {
    @Binding var selectedTab: String
    
    @State var isSheetPresented: Bool = true
    
    @State var showRed: Bool = true
    
    var body: some View {
        ZStack {
            TimeDialView()
            
        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                Text("Sheet Content (RedView)")
                
                VStack {
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Button() {
                            
                        } label: {
                            Label("Red", systemImage: "star.fill")
                            
                        }
                        .frame(width: 100)
                        
                        Spacer()
                        
                        Button() {
                            isSheetPresented = false
                            
                            selectedTab = "green"
                            
                        } label: {
                            Label("Green", systemImage: "star.fill")
                            
                        }
                        .frame(width: 100)
                        
                        Spacer()
                        
                        Button() {
                            isSheetPresented = false
                            
                            selectedTab = "yellow"
                            
                        } label: {
                            Label("Yellow", systemImage: "star.fill")
                            
                        }
                        .frame(width: 100)
                        
                        Spacer()
                        
                    }
                }
            }
            .presentationDetents([.medium, .fraction(0.40), .fraction(0.93)])
            .interactiveDismissDisabled()
            .presentationCornerRadius(25)
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            
        }
        .onAppear() {
            isSheetPresented = true
            
        }
    }
}

struct GreenView: View {
    var body: some View {
        ZStack {
            Color(.green)
                .edgesIgnoringSafeArea(.all)
            
            Text("GreenView Content")
            
        }
    }
}

struct YellowView: View {
    var body: some View {
        ZStack {
            Color(.yellow)
                .edgesIgnoringSafeArea(.all)
            
            Text("YellowView Content")
            
        }
    }
}

struct ContentView: View {
    @State var selectedTab: String = "red"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RedView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Red", systemImage: "star.fill")
                    
                }
                .tag("red")
            
            GreenView()
                .tabItem {
                    Label("Green", systemImage: "star.fill")
                    
                }
                .tag("green")
            
            // YellowView option
            YellowView()
                .tabItem {
                    Label("Yellow", systemImage: "star.fill")
                    
                }
                .tag("yellow")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
