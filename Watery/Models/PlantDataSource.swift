//
//  PlantDataSource.swift
//  Watery
//
//  Created by Etienne Grey on 3/25/24 @ 1:59 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation
import SwiftData

final class PlantDataSource {
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    @MainActor
    static let shared = PlantDataSource()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Plant.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func appendPlant(plant: Plant) {
        modelContext.insert(plant)
        do {
            try modelContext.save()
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchItems() -> [Plant] {
        do {
            return  try modelContext.fetch(FetchDescriptor<Plant>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeItem(_ plant: Plant) {
        modelContext.delete(plant)
    }
}
