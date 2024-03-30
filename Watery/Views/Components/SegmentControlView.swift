//
//  SegmentControlView.swift
//  Watery
//
//  Created by Etienne Grey on 3/24/24 @ 11:30 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI

struct SegmentControlItem {
    var name: String? = nil
}

public struct SegmentControl: View {
    @Environment(ThemeManager.self) private var themeManager
    @Binding var selectedIndex: Int
    let options: [SegmentControlItem]
    
    public var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 6.0)
                    .foregroundColor(themeManager.purpColor)
                    .cornerRadius(6.0)
                    .padding(4)
                    .frame(width: geo.size.width / CGFloat(options.count))
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                    .offset(x: geo.size.width / CGFloat(options.count) * CGFloat(selectedIndex), y: 0)
            }
            .frame(height: 60)
            
            HStack(spacing: 0) {
                ForEach((0..<options.count), id: \.self) { index in
                    HStack(spacing: 6) {
                        if let name = options[index].name {
                            if selectedIndex == index {
                                Text(name)
                                    .foregroundStyle(.black)
                                    .bold()
                            } else {
                                Text(name)
                                //.foregroundStyle(.black)
                                    .bold()
                            }
                        }
                    }
                    .font(.system(size: 16, weight: .regular))
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.150)) {
                            selectedIndex = index
                        }
                    }
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 6.0)
                .fill(themeManager.currentTheme.accentColor)
        )
    }
}
