//
//  ContentView.swift
//  Watery
//
//  Created by Etienne Grey on 3/24/24 @ 3:52 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI


struct ContentView: View {
    
    @State var themeManager: ThemeManager = ThemeManager()
    
    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
                    .environment(themeManager)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                GardenView()
                    .environment(themeManager)
            }
            .tabItem {
                Label("Garden", systemImage: "leaf")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Plant.self)
    
}
