//
//  PlantViewModelProtocol.swift
//  Watery
//
//  Created by Etienne Grey on 3/30/24 @ 5:32 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation

protocol PlantViewModel {
    
    var allPlants: [Plant] { get }
    
    func addPlant(newPlant: Plant)
    
}
