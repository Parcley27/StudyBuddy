//
//  HomeView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 14/9/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    
    @State var isSheetPresented: Bool = true
    
    @State var showRed: Bool = true
    
    let spacingAmount: CGFloat = 13
    
    var body: some View {
        ZStack {
            TimeDialView()
            
        }
        .sheet(isPresented: $isSheetPresented) {
            ZStack {
                Text("Sheet Content (HomeView)")
                
                List {
                    ForEach(1 ... 20, id: \.self) { index in
                        Text("Item \(index)")
                    }
                }
                .listStyle(.plain)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        TabItemView("Home", "house.fill")
                            .frame(width: 50)
                            .foregroundStyle(.blue)
                            .padding(.trailing, spacingAmount)
                            .frame(width: 100)
                        
                        Spacer()
                        
                        Button() {
                            isSheetPresented = false
                            
                            selectedTab = "green"
                            
                        } label: {
                            TabItemView("Explore", "map.fill")
                                .foregroundStyle(.gray)
                            
                        }
                        .frame(width: 50)
                        .frame(width: 100)
                        
                        Spacer()
                        
                        Button() {
                            isSheetPresented = false
                            
                            selectedTab = "profile"
                            
                        } label: {
                            TabItemView("Profile", "person.fill")
                                .foregroundStyle(.gray)
                            
                        }
                        .frame(width: 50)
                        .padding(.leading, spacingAmount)
                        .frame(width: 100)
                        
                        Spacer()
                        
                    }
                    .padding(.top, 40)
                    .background(
                        ZStack {
                            // Use Color(.clear) for the bar background
                            Color(.red)
                                .edgesIgnoringSafeArea(.all)
                                //.background(.bar)
                            
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0),
                                    Color.white.opacity(0.3),
                                    Color.white.opacity(0.8),
                                    Color.white.opacity(1)
                                ]),
                                startPoint: .center,
                                endPoint: .top
                            )
                            .blendMode(.destinationOut)
                        }
                    )
                    .compositingGroup() // Blend out to clear rather than black
                    
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

#Preview {
    @Previewable @State var selectedTab: String = "home"
    HomeView(selectedTab: $selectedTab)
    
}
