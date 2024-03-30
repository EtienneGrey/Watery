//
//  GardenPlantCell.swift
//  Watery
//
//  Created by Etienne Grey on 3/30/24 @ 5:15 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI
import SwiftData

struct GardenPlantCell: View {
    
    
    
    @Bindable var plant: Plant
    @State private var isCompleted: Bool = false
    
    @Environment(ThemeManager.self) private var themeManager
    var gardenVM: GardenViewModel
    
    @Binding var isEditing: Bool
    
    var body: some View {
        
        VStack(spacing: 10) {
            ZStack {
                if let imageData = plant.imageData {
                    Image(uiImage: UIImage(data: imageData) ?? UIImage(imageLiteralResourceName: "empty-image"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                } else {
                    Image("empty-image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                if isEditing {
                    Button {
                        withAnimation(.easeInOut) {
                            gardenVM.removePlant(plant: plant)
                        }
                    } label: {
                        Image(systemName: "trash.slash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundStyle(.red)
                            .bold()
                            .background() {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.black.opacity(0.45))
                                    .frame(width: 125, height: 125)
                            }
                    }
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(plant.name)
                        .font(.title3)
                        .bold()
                }
                
                Text("• Breed: \(plant.plantType)")
                    .font(.caption)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                Text("• Water Amount: \(plant.waterAmount) \(plant.waterAmountUnit)")
                    .font(.caption)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                Text("• Frequency: \(plant.wateringFrequencyDays) days")
                    .font(.caption)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
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
    
    let plant = Plant(id: UUID().uuidString, name: "Plant Name", plantType: "Plant Type", lastWateredDate: .now, wateringFrequencyDays: 5)
    return GardenPlantCell(plant: plant, gardenVM: GardenViewModel(), isEditing: .constant(false))
        .environment(ThemeManager())
        .modelContainer(container)
        .preferredColorScheme(.dark)
}
