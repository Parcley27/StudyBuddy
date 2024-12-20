//
//  ProfileView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 14/9/24.
//

import SwiftUI
import Charts

struct ProfileView: View {
    @Binding var profileData: ProfileData
    
    @AppStorage("doVisualEffects") var doVisualEffects: Bool = true
    @AppStorage("preferredTheme") var preferredTheme: String = "Default"
    
    @State private var isEditProfilePresented: Bool = false
    @State private var isAddFriendsPresented: Bool = false
        
    @State private var chartRange: String = "week"
    @State private var chartDayRange: Int = 7
    
    @State var averageStudyTime: Double = HistoryData.averageMinutesStudied(data: ProfileData.mock.historyData, range: 7)
    
    func updateChartRange(to range: String, days: Int) {
        chartRange = range
        chartDayRange = days
        averageStudyTime = HistoryData.averageMinutesStudied(data: profileData.historyData, range: days)
    }
    
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

                                    ProgressView(time: 600.0, maxTime: 1000.0, maxWidth: 172)
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
                        ZStack(alignment: .topLeading) {
                            VStack(alignment: .leading) {
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
                                            updateChartRange(to: "week", days: 7)
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
                                            updateChartRange(to: "month", days: 30)
                                        }
                                        
                                        ZStack {
                                            Capsule()
                                                .fill(chartRange == "year" ? Color.white : Color.clear)
                                                .strokeBorder(chartRange == "year" ? Color.whitePrimary : Color.backgroundSecondary, lineWidth: 1)
                                                .frame(width: 85, height: 30)
                                            
                                            Text("This Year")
                                                .font(.custom("Inter24pt-Medium", size: 13))
                                                .foregroundColor(chartRange == "year" ? Color.black : Color.whitePrimary)
                                            
                                        }
                                        .onTapGesture {
                                            updateChartRange(to: "year", days: 365)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        let hours = Int(averageStudyTime / 60)
                                        let minutes = Int(averageStudyTime) % 60
                                        
                                        Text("\(hours)\(hours == 1 ? " hr," : " hrs,") \(minutes) min")
                                            .font(.custom("Inter24pt-SemiBold", size: 20))
                                            .foregroundStyle(Color.whitePrimary)
                                        
                                        Text("Average Time Studied")
                                            .font(.custom("Inter24pt-Regular", size: 13))
                                            .foregroundStyle(Color.secondary)
                                        
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 10)
                                ChartView(
                                    height: 125,
                                    daysToShow: $chartDayRange,
                                    averageStudyTime: $averageStudyTime,
                                    chartData: $profileData.historyData
                                )
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.backgroundSecondary, lineWidth: 1)
                        )
                        .padding(.horizontal)
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
    @Previewable @State var profileData: ProfileData = ProfileData.mock
    
    ProfileView(profileData: $profileData)
    
}
