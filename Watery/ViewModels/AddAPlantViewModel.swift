//
//  AddAPlantViewModel.swift
//  Watery
//
//  Created by Etienne Grey on 3/25/24 @ 2:46 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import Foundation
import SwiftUI
import PhotosUI

@Observable
class AddAPlantViewModel {
    
    var plantName: String = ""
    var plantType: String = ""
    
    var selectedItem: PhotosPickerItem?
    var selectedImage: Data?
    
    let options1: [SegmentControlItem] = [
        SegmentControlItem(name: "None"),
        SegmentControlItem(name: "Some"),
        SegmentControlItem(name: "Alot"),
    ]
    
    let options2: [SegmentControlItem] = [
        SegmentControlItem(name: "1"),
        SegmentControlItem(name: "2"),
        SegmentControlItem(name: "3"),
        SegmentControlItem(name: "4"),
        SegmentControlItem(name: "5"),
        SegmentControlItem(name: "6"),
        SegmentControlItem(name: "7"),
        SegmentControlItem(name: "8"),
        SegmentControlItem(name: "9"),
        SegmentControlItem(name: "10")
    ]
    
    var selectedLightIndex = 1
    var plantDiameterIndex = 2
    
    func recommendedWaterVolume(forDiameter diameter: Int) -> Int {
        let updatedDiameter = diameter + 1
        switch updatedDiameter {
        case 1:
            return 40 // Average of 30-50ml
        case 2:
            return 75 // Average of 50-100ml
        case 3:
            return 125 // Average of 100-150ml
        case 4:
            return 175 // Average of 150-200ml
        case 5:
            return 225 // Average of 200-250ml
        case 6:
            return 275 // Average of 250-300ml
        case 7:
            return 350 // Average of 300-400ml
        case 8:
            return 450 // Average of 400-500ml
        case 9:
            return 550 // Average of 500-600ml
        case 10:
            return 675 // Average of 600-750ml
        default:
            print("Diameter out of range. Please enter a value between 1 and 10 inches.")
            return 0 // Return 0 for out of range values
        }
    }

    func createPlantObject() -> Plant {
        var wateringFrequency: Int = 0
        
        if selectedLightIndex == 0 { //None
            wateringFrequency = 10
        } else if selectedLightIndex == 1 { //Some
            wateringFrequency = 8
        } else if selectedLightIndex == 2 { //Alot
            wateringFrequency = 5
        }
        
        let tempPlant = Plant()
        
        tempPlant.name = plantName
        tempPlant.plantType = plantType
        tempPlant.wateringFrequencyDays = wateringFrequency
        tempPlant.diameter = plantDiameterIndex + 1
        tempPlant.waterAmount = recommendedWaterVolume(forDiameter: plantDiameterIndex)
        
        if let selectedImage = selectedImage {
            tempPlant.imageData = selectedImage
        }
        
        return tempPlant
    }
    
    
}
