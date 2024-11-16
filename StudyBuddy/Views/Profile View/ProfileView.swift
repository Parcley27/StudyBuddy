//
//  ProfileView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 14/9/24.
//

import SwiftUI
import Charts

struct ProfileView: View {
    @State private var profileData = ProfileData.mockData()
    
    @AppStorage("doVisualEffects") var doVisualEffects: Bool = true
    @AppStorage("preferredTheme") var preferredTheme: String = "Default"
    
    @State private var isEditProfilePresented: Bool = false
    @State private var isAddFriendsPresented: Bool = false
    
    @State var mainID: Int?
    
    @State private var chartRange: String = "week"
    @State private var chartDayRange: Int = 7
    
    var body: some View {
        NavigationStack {
            ZStack {
                if preferredTheme == "Default" {
                    Color.backgroundPrimary
                        .ignoresSafeArea()
                    
                }
                
                if doVisualEffects {
                    VStack { // Glow
                        ZStack {
                            Circle()
                                .fill(.blue)
                                .frame(width: 200, height: 100)
                                .blur(radius: 100)
                            
                            Circle()
                                .fill(.purple)
                                .frame(width: 200, height: 100)
                                .blur(radius: 100)
                            
                            Circle()
                                .fill(.purple)
                                .frame(width: 200, height: 100)
                                .blur(radius: 100)
                            
                            Circle()
                                .fill(.blue)
                                .frame(width: 200, height: 100)
                                .blur(radius: 100)
                            
                        }
                        
                        Spacer()
                        
                    }
                    .ignoresSafeArea(.all)
                    
                }
                
                ScrollView {
                    LazyVStack {
                        HStack(alignment: .center) {
                            ZStack {
//                                Circle()
//                                    .fill(Color("3D4399"))
//                                    .frame(width: 92, height: 92)
//                                    .blur(radius: 5)
                                
                                Circle()
                                    .fill(Color.greyPrimary)
                                    .frame(width: 90, height: 90)
                                Image(systemName: "person.fill")
                                    .font(.system(size: 58))
                                    .foregroundStyle(Color.backgroundPrimary)
                                
                            }
                            .padding()
                            
                            VStack(alignment: .leading) {
                                Text(profileData.name)
//                                    .font(.title)
                                    .font(.custom("Inter24pt-Bold", size: 20))
                                
                                Text("@\(profileData.username)")
                                    .font(.custom("Inter24pt-Regular", size: 16))
                                
//                                Rectangle()
//                                    .fill(Color("3D4399"))
//                                    .frame(maxWidth: .infinity)
//                                    .frame(height: 1)
                                
                                HStack(alignment: .top) {
                                    StatsView(String(profileData.level), "⭐", "Level")
                                    StatsView(String(profileData.streak), "🔥", "Streak")
                                    StatsView(String(profileData.totalHours), "⏰", "Hours")
                                    
                                }
//                                .padding(.top, -5)
                            }
                            
                            Spacer()
                            
                        }
                        
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.backgroundSecondary, lineWidth: 1)
                            .frame(height: 60)
                            .background(Color.clear)
                            .cornerRadius(10)
                            .padding(.horizontal, 16)
                            .overlay(
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(profileData.rank)
                                            .font(.custom("Inter24pt-SemiBold", size: 16))
                                            .foregroundColor(.primary)
                                        
                                        Text("Rank")
                                            .font(.custom("Inter24pt-Regular", size: 13))
                                            .foregroundColor(.secondary)
                                        
                                    }
                                    .padding(.leading, 30)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(profileData.rankEmoji)
                                            .font(.custom("Inter24pt-SemiBold", size: 30))
                                            .foregroundColor(.primary)
                                        
                                    }
                                    .frame(maxHeight: .infinity, alignment: .center)

                                    Spacer()

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Something")
                                            .font(.custom("Inter24pt-SemiBold", size: 16))
                                            .foregroundColor(.primary)
                                        
                                        Text("Something")
                                            .font(.custom("Inter24pt-Regular", size: 13))
                                            .foregroundColor(.secondary)
                                        
                                    }
                                    .padding(.trailing, 30) // Padding from the right edge of the rectangle
                                    .frame(maxHeight: .infinity, alignment: .center)
                                    
                                }
                            )
                            .padding(.bottom)
                        
                        HStack(spacing: 10) {
                            Button(action: {
                                isAddFriendsPresented = true
                                
                            }) {
                                Capsule(style: .continuous)
                                    .fill(Color.purplePrimary)
                                    .frame(maxWidth: .infinity, minHeight: 32)
                                    .overlay(
                                        Text("Add Friends")
                                            .foregroundColor(Color.whitePrimary)
                                            .font(.custom("Inter24pt-SemiBold", size: 16))
                                        
                                    )
                            }
                            .fullScreenCover(isPresented: $isAddFriendsPresented) {
                                AddFriendsView()
                                
                            }

                            Button(action: {
                                isEditProfilePresented = true
                                
                            }) {
                                Capsule(style: .continuous)
                                    .fill(Color("3D4399"))
                                    .frame(maxWidth: .infinity, minHeight: 32)
                                    .overlay(
                                        Text("Edit Profile")
                                            .foregroundColor(Color.whitePrimary)
                                            .font(.custom("Inter24pt-SemiBold", size: 16))
                                        
                                    )
                            }
                            .fullScreenCover(isPresented: $isEditProfilePresented) {
                                EditProfileView()
                                
                            }
                        }
                        .padding(.horizontal) // spacing between buttons and edge of screen
                        
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                
                                Text("About")
                                    .font(.custom("Inter24pt-SemiBold", size:16))
                                    .foregroundStyle(Color.greyPrimary)
                                    .padding(.bottom, 1)
                                
                                Text(profileData.aboutMe)
                                    .font(.custom("Inter24pt-Regular", size: 16))
                                
                                Text("Joined \(profileData.joinDate.mediumFormat) · \(profileData.joinDate.daysAgoDescription)")
                                    .font(.custom("Inter24pt-Regular", size: 14))
                                    .foregroundStyle(Color.greyPrimary)
                                    .padding(.top, 1)
                                
                            }
                            .padding()
                            
                            Spacer()
                            
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color.backgroundSecondary, lineWidth: 1)
                                .frame(width: screenBounds().width - 32, height: 235)
                                .foregroundStyle(Color.backgroundPrimary)
                            
                            // Adding actual functionalty later, this is just a ui mock up for rn
                            VStack(alignment: .leading) {
                                HStack {
                                    ZStack {
                                        Capsule()
                                            .fill(chartRange == "week" ? Color.white : Color.clear)
                                            .strokeBorder(chartRange == "week" ? Color.whitePrimary : Color.backgroundSecondary, lineWidth: 1)
                                            .frame(width: 60, height: 30)

                                        Text("Week")
                                            .font(.custom("Inter24pt-Medium", size: 13 ))
                                            .foregroundColor(chartRange == "week" ? Color.black : Color.whitePrimary)
                                        
                                    }
                                    .onTapGesture {
                                        chartRange = "week"
                                        chartDayRange = 7
                                        
                                    }
                                    
                                    ZStack {
                                        Capsule()
                                            .fill(chartRange == "month" ? Color.white : Color.clear)
                                            .strokeBorder(chartRange == "month" ? Color.whitePrimary : Color.backgroundSecondary, lineWidth: 1)
                                            .frame(width: 65, height: 30)

                                        Text("Month")
                                            .font(.custom("Inter24pt-Medium", size: 13))
                                            .foregroundColor(chartRange == "month" ? Color.black : Color.whitePrimary)
                                        
                                    }
                                    .onTapGesture {
                                        chartRange = "month"
                                        chartDayRange = 30
                                        
                                    }
                                    
                                    ZStack {
                                        Capsule()
                                            .fill(chartRange == "all" ? Color.white : Color.clear)
                                            .strokeBorder(chartRange == "all" ? Color.whitePrimary : Color.backgroundSecondary, lineWidth: 1)
                                            .frame(width: 75, height: 30)

                                        Text("All Time")
                                            .font(.custom("Inter24pt-Medium", size: 13))
                                            .foregroundColor(chartRange == "all" ? Color.black : Color.whitePrimary)
                                        
                                    }
                                    .onTapGesture {
                                        chartRange = "all"
                                        chartDayRange = 60
                                        
                                    }
                                }
                                .padding(.bottom, 3)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("4 Hrs, 20 Mins")
                                        .font(.custom("Inter24pt-SemiBold", size: 20))
                                        .foregroundStyle(Color.whitePrimary)
                                    
                                    Text("Average Time Studied")
                                        .font(.custom("Inter24pt-Regular", size: 13))
                                        .foregroundStyle(Color.secondary)
                                    
                                }
                                
                                ChartView(height: 120, daysToShow: $chartDayRange)
                                
                            }
                            .padding(.horizontal, 35)
                            
                        }
//                      .padding()
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pellentesque, mauris sit amet lacinia semper, sem libero tempus metus, quis pellentesque nulla quam id sem. Nam bibendum est a imperdiet fermentum. Integer sit amet risus risus. Nullam interdum pulvinar tellus, ac dictum arcu semper id. Quisque ornare eget nisi at pharetra. Nunc a eros eu augue accumsan sodales. Quisque vehicula nisi quis turpis cursus, et interdum dolor pulvinar. Duis ultricies rutrum nunc, ac consectetur justo venenatis id. Duis fringilla est lectus, nec mollis nunc consequat eu. Suspendisse ac justo venenatis, commodo ipsum in, cursus nunc. Quisque dictum nisl in nisl auctor, id feugiat turpis congue. Aliquam erat volutpat. Integer tincidunt hendrerit augue, quis feugiat felis porttitor vel. Proin non fringilla mauris, in vehicula massa. Nam est justo, viverra quis risus sed, placerat molestie urna. Etiam volutpat condimentum libero vel hendrerit.")
                            .padding()
                        /*
                            .onAppear() {
                                // Display all fonts available to the app
                                
                                for family: String in UIFont.familyNames {
                                    print(family)
                                
                                    for names: String in UIFont.fontNames(forFamilyName: family) {
                                        print("-- \(names)")
                                        
                                    }
                                }
                            }
                         */
                        
                    }
                }
                
                // Top edge blur out
                if doVisualEffects {
                    VStack {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .foregroundStyle(.clear)
                            .background(BlurEffectView())
                            .mask(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .black.opacity(1), location: 0), // Full blur at the top
                                        .init(color: .black.opacity(0.00), location: 1.0) // Fade out slowly
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        
                        Spacer()
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                    
                }
            }
            //.navigationTitle("Profile")
            //.navigationBarTitleDisplayMode(.inline)
            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    CloseIconView()
//
//                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ShareIconView()
                    
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    SettingsIconView()
                    
                }
            }
            .toolbarBackground(
                Color.backgroundPrimary.opacity(1)
                
            )
            .toolbarBackgroundVisibility(doVisualEffects ? .hidden : .automatic)
            
        }
    }
}

#Preview {
    ProfileView()
    
}
