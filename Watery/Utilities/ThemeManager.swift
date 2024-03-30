//
//  ThemeManager.swift
//  Watery
//
//  Created by Etienne Grey on 3/24/24 @ 7:02 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//

import Foundation
import SwiftUI

@Observable
class ThemeManager {
    var currentTheme: Theme
    
    let purpColor = Color(red: 210/255, green: 180/255, blue: 250/255)
    
    init() {
        currentTheme = .dark
    }
}

extension Theme {
    static let dark = Theme(
        id: "dark",
        backgroundColor: Color(red: 16/255, green: 16/255, blue: 16/255),
        primaryTextColor: Color(red: 255/255, green: 255/255, blue: 255/255),
        secondaryTextColor: .gray, accentColor: Color(red: 34/255, green: 34/255, blue: 34/255)
    )
    
    static let allThemes = [dark]
}


struct Theme: Equatable, Identifiable {
    var id: String
    var backgroundColor: Color
    var primaryTextColor: Color
    var secondaryTextColor: Color
    var accentColor: Color
}
