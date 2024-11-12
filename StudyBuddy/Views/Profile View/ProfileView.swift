//
//  ProfileView.swift
//  StudyBuddy
//
//  Created by Pierce Oxley on 14/9/24.
//

import SwiftUI

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
        VStack(alignment: .leading, spacing: 0) {
            Text("\(stat) \(emoji)")
                .bold()
            Text(caption)
                .font(.caption)
                .foregroundStyle(.secondary)
            
        }
        .padding(.vertical, 2)
        .frame(width: 70, alignment: .leading)
        
    }
}

struct SettingsIcon: View {
    var body: some View {
        ZStack {
            NavigationLink {
                SettingsView()
                
            } label: {
                Image(systemName: "gearshape")
                    .padding(4)
                    .background(.bar, in: Circle())
                    .foregroundStyle(.white)
                
            }
        }
    }
}

struct ShareIcon: View {
    var body: some View {
        ShareLink(item: "Hello, Profile Sharing!") {
            Image(systemName: "square.and.arrow.up")
                .padding(.bottom, 2)
                .padding(6)
                .background(.bar, in: Circle())
                .foregroundStyle(.white)
            
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
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
                
                ScrollView {
                    LazyVStack {
                        HStack(alignment: .bottom) {
                            ZStack {
                                Circle()
                                    .fill(Color("3D4399"))
                                    .frame(width: 92, height: 92)
                                    .blur(radius: 5)
                                
                                Circle()
                                    .fill(.gray)
                                    .frame(width: 90, height: 90)
                                Image(systemName: "person.fill")
                                    .font(.system(size: 58))
                                    .foregroundStyle(.background)
                                
                            }
                            .padding()
                            
                            VStack(alignment: .leading) {
                                Text("Hello, **Name**")
                                    .font(.title)
                                    //.font(.custom("Inter24pt-Bold", size: 24))
                                Text("@username")
                                
                                Rectangle()
                                    .fill(Color("3D4399"))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 1)
                                
                                HStack(alignment: .top) {
                                    StatsView("3.5k", "💡", "IQ")
                                    StatsView("71d", "🔥", "Streak")
                                    StatsView("Bio", "🧬", "Fav. Subject")
                                    
                                }
                            }
                            
                            Spacer()
                            
                        }
                        
                        HStack(spacing: 20) {
                            Capsule(style: .continuous)
                                .fill(Color("3D4399"))
                                .frame(width: 150, height: 25)
                                .overlay(
                                    Text("Add Friends")
                                        .foregroundColor(.white)
                                    
                                )
                                                        
                            Capsule(style: .continuous)
                                .fill(Color("3D4399"))
                                .frame(width: 150, height: 25)
                                .overlay(
                                    Text("Edit Profile")
                                        .foregroundColor(.white)
                                )
                        }
                        
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
                ToolbarItem(placement: .topBarTrailing) {
                    ShareIcon()
                    
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    SettingsIcon()
                    
                }
            }
            .toolbarBackground(
                RadialGradient(gradient: Gradient(colors: [.clear, .yellow, .green, .blue, .purple]), center: .center, startRadius: 50, endRadius: 100)

            )
            .toolbarBackgroundVisibility(.hidden)
            
        }
    }
}

#Preview {
    ProfileView()
    
}
