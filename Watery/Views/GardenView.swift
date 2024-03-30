//
//  GardenView.swift
//  Watery
//
//  Created by Etienne Grey on 3/30/24 @ 5:04 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI

struct GardenView: View {
    @Environment(ThemeManager.self) private var themeManager
    @Environment(\.modelContext) private var context
    
    @State private var gardenVM: GardenViewModel = GardenViewModel()
    
    @State private var isAddViewPresented: Bool = false
    @State private var offsets = [CGSize](repeating: CGSize.zero, count: 6)
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                if gardenVM.allPlants.isEmpty {
                    ContentUnavailableView("Your garden is empty!", systemImage: "leaf")
                        .frame(height: UIScreen.main.bounds.height / 1.5)
                } else{
                    LazyVGrid(columns: columns, spacing: 16) {
                        // Loop through the plants array to create a cell for each item
                        ForEach(gardenVM.allPlants, id: \.self) { plant in
                            GardenPlantCell(plant: plant) // Assuming your GardenPlantCell accepts a plant parameter
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Your Garden")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isAddViewPresented.toggle()
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(themeManager.purpColor)
                            .padding(5)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddViewPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(themeManager.purpColor)
                            .padding(5)
                    }
                }
            }
        }
        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
        .sheet(isPresented: $isAddViewPresented, content: {
            NavigationStack {
                AddAPlantView(plantViewModel: gardenVM)
                    .environment(themeManager)
            }
        })
        .onAppear() {
            gardenVM.initPlants()
        }
    }
}

#Preview {
    NavigationStack {
        GardenView()
            .environment(ThemeManager())
            .preferredColorScheme(.dark)
            .modelContainer(for: Plant.self)
    }
}

