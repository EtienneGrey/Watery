//
//  DashboardView.swift
//  Watery
//
//  Created by Etienne Grey on 3/24/24 @ 3:54 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(ThemeManager.self) private var themeManager
    @Environment(\.modelContext) private var context
    
    @State private var dashboardVM: DashboardViewModel = DashboardViewModel()
    
    @State private var isAddViewPresented: Bool = false
    @State private var offsets = [CGSize](repeating: CGSize.zero, count: 6)
    
    var body: some View {
        
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    if dashboardVM.allPlants.isEmpty {
                        ContentUnavailableView("Your garden is empty!", systemImage: "leaf")
                            .frame(height: UIScreen.main.bounds.height / 1.5)
                    } else {
                        if !dashboardVM.plantTasksDueToday.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("Due Later This Week")
                                    .font(.title2)
                                    .bold()
                                
                                ForEach(dashboardVM.plantTasksDueToday) { plant in
                                    PlantCell(plant: plant)
                                        .environment(themeManager)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Due Later This Week")
                                .font(.title2)
                                .bold()
                            ForEach(dashboardVM.plantTasksDueLater) { plant in
                                PlantCell(plant: plant)
                                    .environment(themeManager)
                            }
                        }
                        
                    }
                }
                .padding()
                .navigationTitle("Tasks")
                .toolbar {
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
        }
        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
        .sheet(isPresented: $isAddViewPresented, content: {
            NavigationStack {
                AddAPlantView(plantViewModel: dashboardVM)
                    .environment(themeManager)
            }
        })
        .onAppear() {
            dashboardVM.initPlants()
        }
    }
}

#Preview {
    NavigationStack {
        DashboardView()
            .environment(ThemeManager())
            .preferredColorScheme(.dark)
            .modelContainer(for: Plant.self)
    }
}
