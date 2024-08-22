//
//  ContentView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 2024-06-21.
//

// READ ME FOR EXPLAINATIONS OF THIS FILE AND CONTENT
// The ContentView file has 4 actual views in it right now
// In the real app, each view would have its own file, and subviews with their own files too

// Import SwiftUI for all the UI elements
import SwiftUI
// We would use this if we wanted to store/access app data with this view
//import SwiftData

// A red screen with other stuff
// A view is declared as a struct with a "View" type
// The actual UI stuff is put under the struct's body variable, also with a "some View" tag
struct RedView: View {
    // Variables are not given values but are given types so can be used as input for RedView
    // These are decalred in a local scope (confined to RedView), but because they aren't given a value, a value must be provided by whatever calls it, in this case, ContentView
    // The @Binding property of this one makes it inherit, or get information from another place
    // If this view is active, the view that called this one (parent) can remotely control the value of any @Binding variables to cause updates in the child view
    @Binding var selectedTab: String
    
    // Set the default value to true, and to show the sheet
    // @State means that updates will be pushed live to a view (ie: a var update causes a view update)
    // Swift can detect variable types, but they can also be assigned for whatever reason, in this case to a String
    @State var isSheetPresented: Bool = true
    
    // Used to change background colour
    @State var showRed: Bool = true
    
    var body: some View {
        // Depth Stack, or stacked items in vertical layers
        // The later the thing is created the higher it goes
        ZStack {
            // This will make the background diffirent depending on the state of showRed
            // It's a single line if statment that can be used to hold two outputs
            // Like this: [variableName] == [desired state] ? [return thing a] : [return thing b]
            // It defaults to if the variable is true in this case
            Color(showRed ? .red : .purple)
                .onTapGesture {
                    // When the colour is tapped, it will change the colour of the view
                    showRed.toggle()
                    
                }
                // Pushes colour right to the edge
                .edgesIgnoringSafeArea(.all)
            
            Text("RedView Content")
            
        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                Color(.white)
                    .edgesIgnoringSafeArea(.all)
                
                Text("Sheet Content")
                
                // Vertical stack, the later the thing is created the lower it goes
                VStack {
                    Spacer()
                    
                    // Horizontal stack, things go in from left to right
                    HStack {
                        // Make this look exactly like the normal tab view later
                        
                        Spacer()
                        
                        // Buttons to change the selected tab
                        Button() {
                            // Already on RedView, no action needed
                            
                        } label: {
                            // Can also have a custom label, or an entire view as a lable for complex buttons
                            Label("Red", systemImage: "star.fill")
                            
                        }
                        // All buttons get the same width so that the space properly, otherwise smaller buttons would get pushed around more
                        .frame(width: 100)
                        
                        Spacer()
                        
                        Button() {
                            // Hide the sheet
                            // Could also go in .onDisappear below .onAppear a bit later
                            isSheetPresented = false
                            
                            // Go to the green ContentView tab
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
            // Stuff to control interaction on the sheet (the white thing)
            // This is the available sizes of the sheet (try dragging the top of it up/down)
            .presentationDetents([.medium, .fraction(0.3)])
            
            // Prevents the user from swiping it away fully
            .interactiveDismissDisabled()
            
            // Corner radius of the sheet, defaults to 10 or something
            .presentationCornerRadius(25)
            
            // Allows interaction behind the sheet to the rest of RedView, up to a provided point
            // In this case when the sheet is half way up the screen in the .medium size
            .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            
        }
        .onAppear() {
            // Bring back the sheet as soon as the red view is visable
            isSheetPresented = true
            
        }
    }
}

// A green screen
struct GreenView: View {
    var body: some View {
        ZStack {
            Color(.green)
                .edgesIgnoringSafeArea(.all)
            
            Text("GreenView Content")
            
        }
    }
}

// A yellow screen
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
    // Controls the selected tab in the tab view
    // Would otherwise just default to the left most tab
    @State var selectedTab: String = "green"
    
    var body: some View {
        // The tab view along the bottom
        // It's selection is whatever section has a tag that matches the selection input $selectedTab
        // The "$" before the variable means that the view will update when selectedTab changes, or the view can make changes to the value
        // For example in a toggle, the toggle can change the state of the var and vice versa
        // Toggle(isOn: $var)
        TabView(selection: $selectedTab) {
            // Any view you want to have in the TabView
            // RedView option
            RedView(selectedTab: $selectedTab)
                .tabItem {
                    // How to display the button for the view, it's the same as a label for a button
                    Label("Red", systemImage: "star.fill")
                }
                // TabView tag
                // When selectedTab is "red" it will go to this one
                .tag("red")
            
            // GreenView option
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

// Creates a preview of a given view off to the right
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // This picks the ContentView for the preview
        ContentView()
        
    }
}
