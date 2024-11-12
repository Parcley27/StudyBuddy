//
//  ProfileView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 14/9/24.
//

import SwiftUI
import Charts

struct StatsView: View {
    init(_ stat: String, _ emoji: String, _ caption: String) {
        self.stat = stat
        self.emoji = emoji
        self.caption = caption
        
    }
    
    @State var stat: String
    @State var emoji: String
    @State var caption: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(stat) \(emoji)")
                .font(.custom("Inter24pt-SemiBold", size: 20))
            Text(caption)
                .font(.custom("Inter24pt-Regular", size: 14))
                .foregroundStyle(.secondary)
            
        }
        .padding(.top, 1)
        .frame(width: 70, alignment: .leading)
        
    }
}

struct CloseIcon: View {
    var body: some View {
        if let image = UIImage(named: "close")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)) {
            Button(action: {
                print("Close button tapped")
            }) {
                Image(uiImage: image)
                    .renderingMode(.template)
                    .foregroundColor(.white)
            }
        } else {
            Text("Image not found")
                .foregroundColor(.red)
        }
    }
}

struct SettingsIcon: View {
    var body: some View {
        if let image = UIImage(named: "settings")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)) {
            ZStack {
                NavigationLink(destination: SettingsView()) {
                    Image(uiImage: image)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
            }
        } else {
            Text("Image not found")
                .foregroundColor(.red)
        }
    }
}

struct ShareIcon: View {
    var body: some View {
        ShareLink(item: "Hello, Profile Sharing!") {
            if let image = UIImage(named: "ios_share")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)) {
                ZStack {
                    Image(uiImage: image)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .padding(.bottom, 1) // Adjust for slightly lower SVG
                }
            } else {
                Text("Image not found")
                    .foregroundColor(.red)
            }
        }
    }
}

struct ProfileView: View {
    @State private var isEditProfilePresented = false
    @State private var isAddFriendsPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("1A1A1A")
                    .ignoresSafeArea()
//                VStack {
//                    ZStack {
//                        Circle()
//                            .fill(.blue)
//                            .frame(width: 200, height: 100)
//                            .blur(radius: 100)
//                        
//                        Circle()
//                            .fill(.purple)
//                            .frame(width: 200, height: 100)
//                            .blur(radius: 100)
//                        
//                        Circle()
//                            .fill(.purple)
//                            .frame(width: 200, height: 100)
//                            .blur(radius: 100)
//                        
//                        Circle()
//                            .fill(.blue)
//                            .frame(width: 200, height: 100)
//                            .blur(radius: 100)
//                        
//                    }
                    
//                    Spacer()
//                    
//                }
//                .ignoresSafeArea(.all)
                
                ScrollView {
                    LazyVStack {
                        HStack(alignment: .center) {
                            ZStack {
//                                Circle()
//                                    .fill(Color("3D4399"))
//                                    .frame(width: 92, height: 92)
//                                    .blur(radius: 5)
                                
                                Circle()
                                    .fill(.gray)
                                    .frame(width: 90, height: 90)
                                Image(systemName: "person.fill")
                                    .font(.system(size: 58))
                                    .foregroundStyle(.background)
                                
                            }
                            .padding()
                            
                            VStack(alignment: .leading) {
                                Text("Pierce Oxley")
//                                    .font(.title)
                                    .font(.custom("Inter24pt-Bold", size: 20))
                                Text("@greenpowderranger")
                                    .font(.custom("Inter24pt-Regular", size: 16))
                                
//                                Rectangle()
//                                    .fill(Color("3D4399"))
//                                    .frame(maxWidth: .infinity)
//                                    .frame(height: 1)
                                HStack(alignment: .top) {
                                    StatsView("30", "⭐", "Level")
                                    StatsView("71", "🔥", "Streak")
                                    StatsView("61", "⏰", "Hours")
                                }
//                                .padding(.top, -5)
                            }
                            
                            Spacer()
                            
                        }

                        HStack(spacing: 10) {
                            Button(action: {
                                isAddFriendsPresented = true
                            }) {
                                Capsule(style: .continuous)
                                    .fill(Color("3D4399"))
                                    .frame(maxWidth: .infinity, minHeight: 32)
                                    .overlay(
                                        Text("Add friends")
                                            .foregroundColor(.white)
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
                                        Text("Edit profile")
                                            .foregroundColor(.white)
                                            .font(.custom("Inter24pt-SemiBold", size: 16))
                                    )
                            }
                            .fullScreenCover(isPresented: $isEditProfilePresented) {
                                EditProfileView()
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                
                                Text("About")
                                    .font(.custom("Inter24pt-SemiBold", size:16))
                                    .foregroundStyle(.secondary)
                                    .padding(.bottom, 1)
                                
                                Text("Hi everyone! My name is Pierce and I love horses, especially Polish ones. I also enjoy iOS development in my free time.")
                                    .font(.custom("Inter24pt-Regular", size: 16))
                                
                                Text("Joined Apr 26, 2024 · 124 days ago")
                                    .font(.custom("Inter24pt-Regular", size: 14))
                                    .foregroundStyle(.secondary)
                                    .padding(.top, 1)
                                
                            } .padding()
                            Spacer()
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: screenBounds().width - 32, height: 200)
                                .foregroundStyle(Color("3B3B3B"))
                            
                            RoundedRectangle(cornerRadius: 11)
                                .frame(width: screenBounds().width - 34, height: 198)
                                .foregroundStyle(Color("1A1A1A"))
                            
                            // Adding actual functionalty later, this is just a ui mock up for rn
                            VStack(alignment: .leading) {
                                HStack {
                                    Capsule()
                                        .frame(width: 85, height: 25)
                                        .foregroundStyle(.white)
                                        .overlay(Text("Week"))
                                        .foregroundStyle(.black)
                                    
                                    Capsule()
                                        .frame(width: 85, height: 25)
                                        .foregroundStyle(Color("3B3B3B"))
                                        .overlay(Text("Month"))
                                    
                                    Capsule()
                                        .frame(width: 85, height: 25)
                                        .foregroundStyle(Color("3B3B3B"))
                                        .overlay(Text("All Time"))
                                        
                                    
                                }
                                .padding(.top)
                                
                                Text("4 Hrs, 20 Min")
                                    .bold()
                                
                                ChartView(height: 120, days: 7)
                                    .padding(.bottom)
                                
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pellentesque, mauris sit amet lacinia semper, sem libero tempus metus, quis pellentesque nulla quam id sem. Nam bibendum est a imperdiet fermentum. Integer sit amet risus risus. Nullam interdum pulvinar tellus, ac dictum arcu semper id. Quisque ornare eget nisi at pharetra. Nunc a eros eu augue accumsan sodales. Quisque vehicula nisi quis turpis cursus, et interdum dolor pulvinar. Duis ultricies rutrum nunc, ac consectetur justo venenatis id. Duis fringilla est lectus, nec mollis nunc consequat eu. Suspendisse ac justo venenatis, commodo ipsum in, cursus nunc. Quisque dictum nisl in nisl auctor, id feugiat turpis congue. Aliquam erat volutpat. Integer tincidunt hendrerit augue, quis feugiat felis porttitor vel. Proin non fringilla mauris, in vehicula massa. Nam est justo, viverra quis risus sed, placerat molestie urna. Etiam volutpat condimentum libero vel hendrerit.")
                            .padding()
                            .onAppear() {
                                // Display all fonts available to the app
                                
                                for family: String in UIFont.familyNames {
                                    print(family)
                                
                                    for names: String in UIFont.fontNames(forFamilyName: family) {
                                        print("== \(names)")
                                        
                                    }
                                }
                            }
                        
                    }
                }
                
            }
            //.navigationTitle("Profile")
            //.navigationBarTitleDisplayMode(.inline)
            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    CloseIcon()
//                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ShareIcon()
                    
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    SettingsIcon()
                    
                }
            }
            .toolbarBackground(
                Color("1A1A1A")

            )
//            .toolbarBackgroundVisibility(.hidden)
            
        }
    }
}

#Preview {
    ProfileView()
    
}
