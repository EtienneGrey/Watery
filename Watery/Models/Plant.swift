//
//  Plant.swift
//  Watery
//
//  Created by Etienne Grey on 3/24/24 @ 7:23 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation
import SwiftData

@Model
class Plant: Identifiable {
    
    @Attribute(.unique) var id: String
    var name: String
    var plantType: String
    var lastWateredDate: Date
    var wateringFrequencyDays: Int // The frequency in days
    var diameter: Int
    var waterAmount: Int
    var waterAmountUnit: String
    var createdTimestamp: Date
    
    @Attribute(.externalStorage) var imageData: Data?
        
    init(id: String = UUID().uuidString, name: String = "", plantType: String = "", lastWateredDate: Date = .now, wateringFrequencyDays: Int = 7, diameter: Int = 3, waterAmount: Int = 125, waterAmountUnit: String = "ml", createdTimestamp: Date = .now) {
        self.id = id
        self.name = name
        self.plantType = plantType
        self.lastWateredDate = lastWateredDate
        self.wateringFrequencyDays = wateringFrequencyDays
        self.diameter = diameter
        self.waterAmount = waterAmount
        self.waterAmountUnit = waterAmountUnit
        self.createdTimestamp = createdTimestamp
    }
}
