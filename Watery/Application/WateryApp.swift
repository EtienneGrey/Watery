//
//  WateryApp.swift
//  Watery
//
//  Created by Etienne Grey on 3/24/24 @ 3:52 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI
import SwiftData

@main
struct WateryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .modelContainer(PlantDataSource.shared.modelContainer)
        }
    }
}
