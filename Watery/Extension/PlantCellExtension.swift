//
//  PlantCellExtension.swift
//  Watery
//
//  Created by Etienne Grey on 3/30/24 @ 5:42 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation


extension PlantCell {
 
    func shouldWaterToday(lastWateredDate: Date?, wateringFrequencyDays: Int) -> Bool {
        guard let lastWateredDate = lastWateredDate else {
            // If there's no last watered date provided, cannot determine, return false or handle appropriately
            return false
        }
        
        // Calculate the next watering date by adding the watering frequency to the last watered date
        if let nextWateringDate = Calendar.current.date(byAdding: .day, value: wateringFrequencyDays, to: lastWateredDate) {
            // Get today's date with time components stripped off for an accurate comparison
            let today = Calendar.current.startOfDay(for: Date())
            let nextWateringDayStart = Calendar.current.startOfDay(for: nextWateringDate)
            
            // Check if the next watering day is today
            return today >= nextWateringDayStart
        }
        
        // In case there's an issue calculating the next watering date, return false or handle appropriately
        return false
    }

    func nextWateringDate(from lastWateredDate: Date?, wateringFrequencyDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: wateringFrequencyDays, to: lastWateredDate!)!
    }

    func daysUntilNextWatering(from lastWateredDate: Date, wateringFrequencyDays: Int) -> Int {
        let lastWateredDate = lastWateredDate
        
        let nextWateringDate = Calendar.current.date(byAdding: .day, value: wateringFrequencyDays, to: lastWateredDate)
        
        let today = Calendar.current.startOfDay(for: Date())
        let nextWateringDayStart = Calendar.current.startOfDay(for: nextWateringDate!)
        
        let components = Calendar.current.dateComponents([.day], from: today, to: nextWateringDayStart)
        return components.day ?? 0
    }
    
}
