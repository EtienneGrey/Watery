//
//  PlantCell.swift
//  Watery
//
//  Created by Etienne Grey on 3/24/24 @ 6:54 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation
import SwiftUI
import SwiftData


struct PlantCell: View {
    
    @Bindable var plant: Plant
    @State private var isCompleted: Bool = false
    @Environment(ThemeManager.self) private var themeManager
    
    var body: some View {
        
        HStack(spacing: 10) {
            
            if let imageData = plant.imageData {
                Image(uiImage: UIImage(data: imageData) ?? UIImage(imageLiteralResourceName: "empty-image"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            } else {
                Image("empty-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(plant.name)
                        .font(.title3)
                        .bold()
                    if daysUntilNextWatering(from: plant.lastWateredDate, wateringFrequencyDays: plant.wateringFrequencyDays) > 0 {
                        Text("Due in \(daysUntilNextWatering(from: plant.lastWateredDate, wateringFrequencyDays: plant.wateringFrequencyDays)) days")
                            .font(.caption2)
                            .foregroundStyle(themeManager.purpColor)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background() {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(themeManager.purpColor.opacity(0.2))
                            }
                    }
                }
                
                Text("\(plant.plantType) • \(plant.waterAmount) \(plant.waterAmountUnit) / \(plant.wateringFrequencyDays) days")
                    .font(.caption)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }
            
            Spacer()
            Button {
                withAnimation(.easeInOut) {
                    isCompleted.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        plant.lastWateredDate = .now
                        isCompleted = false
                    }
                }
            } label: {
                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 33)
                        .foregroundStyle(.green)
                } else {
                    Circle()
                        .stroke(.gray)
                        .frame(width: 30, height: 30)
                }
            }
        }
        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
        .padding()
        .background() {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(themeManager.currentTheme.accentColor)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Plant.self, configurations: config)
    
    let plant = Plant(id: UUID().uuidString, name: "Lucky Bamboo", plantType: "Lucky Bamboo", lastWateredDate: .now, wateringFrequencyDays: 5)
    return PlantCell(plant: plant)
        .environment(ThemeManager())
        .modelContainer(container)
        .preferredColorScheme(.dark)
}
