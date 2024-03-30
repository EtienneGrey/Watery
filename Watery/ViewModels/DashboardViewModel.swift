//
//  DashboardViewModel.swift
//  Watery
//
//  Created by Etienne Grey on 3/24/24 @ 6:52 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation

@Observable
class DashboardViewModel: PlantViewModel {
    
    var allPlants: [Plant] = []
    private let dataSource: PlantDataSource
    var isAddPlantSheetPresented = false
    
    var plantTasksDueToday: [Plant] {
        return allPlants.filter { shouldWaterToday(lastWateredDate: $0.lastWateredDate, wateringFrequencyDays: $0.wateringFrequencyDays) }
    }
    
    var plantTasksForTomorrow: [Plant] {
        
        let plansDueTomorrow = allPlants
            .filter( {
                !shouldWaterToday(lastWateredDate: $0.lastWateredDate, wateringFrequencyDays: $0.wateringFrequencyDays)
            })
            
        return plansDueTomorrow
        
    }
    
    var plantTasksDueLater: [Plant] {
        let plantsDueLater = allPlants
            .filter { !shouldWaterToday(lastWateredDate: $0.lastWateredDate, wateringFrequencyDays: $0.wateringFrequencyDays) }
            .sorted {
                let nextWateringDate1 = nextWateringDate(from: $0.lastWateredDate, wateringFrequencyDays: $0.wateringFrequencyDays)
                
                let nextWateringDate2 = nextWateringDate(from: $1.lastWateredDate, wateringFrequencyDays: $1.wateringFrequencyDays)
                
                return nextWateringDate1 < nextWateringDate2
            }
        return plantsDueLater
    }
    
    init() {
        self.dataSource = PlantDataSource.shared
        initPlants()
    }
    
    //MARK: - SwiftData Methods
    func initPlants() {
        allPlants = dataSource.fetchItems()
    }
    
    func addPlant(newPlant: Plant) {
        
        dataSource.appendPlant(plant: newPlant)
        initPlants()
    }
    
    func removePlant(plant: Plant) {
        dataSource.removeItem(plant)
        initPlants()
    }

    
}
