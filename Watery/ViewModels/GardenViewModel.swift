//
//  GardenViewModel.swift
//  Watery
//
//  Created by Etienne Grey on 3/30/24 @ 5:26 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation

@Observable
class GardenViewModel: PlantViewModel {
    
    var allPlants: [Plant] = []
    private let dataSource: PlantDataSource
    var isAddPlantSheetPresented = false
    
    init() {
        self.dataSource = PlantDataSource.shared
        initPlants()
    }
    
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
