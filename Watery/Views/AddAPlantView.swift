//
//  AddAPlantView.swift
//  Watery
//
//  Created by Etienne Grey on 3/24/24 @ 7:33 PM.
//  Copyright (c) 2024 Etienne Grey. All rights reserved.
//
//  Github: https://github.com/etiennegrey
//  BuyMeACoffee: https://buymeacoffee.com/etiennegrey
//


import SwiftUI
import SwiftData
import PhotosUI

struct AddAPlantView: View {
    
    var plantViewModel: PlantViewModel
    
    @State private var addAPlantVM: AddAPlantViewModel = AddAPlantViewModel()
    
    @Environment(\.modelContext) private var context
    @Environment(ThemeManager.self) private var themeManager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            themeManager.currentTheme.backgroundColor.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    PhotosPicker(selection: $addAPlantVM.selectedItem,
                                 matching: .images) {
                        VStack(alignment: .center, spacing: 10) {
                            if let selectedImage = addAPlantVM.selectedImage {
                                Image(uiImage: UIImage(data: selectedImage) ?? UIImage(imageLiteralResourceName: "empty-image"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            } else {
                                Image("empty-image")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            Text("Add Photo")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextField("", text: $addAPlantVM.plantName)
                            .placeholder(when: addAPlantVM.plantName.isEmpty, placeholder: {
                                Text("Enter a name")
                                    .font(.callout)
                                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor.opacity(0.75))
                            })
                            .padding()
                            .background() {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(themeManager.currentTheme.accentColor)
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Plant Type")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextField("", text: $addAPlantVM.plantType)
                            .placeholder(when: addAPlantVM.plantType.isEmpty, placeholder: {
                                Text("Enter the plant type")
                                    .font(.callout)
                                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor.opacity(0.75))
                            })
                            .padding()
                            .background() {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(themeManager.currentTheme.accentColor)
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("How much light?")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        SegmentControl(
                            selectedIndex: $addAPlantVM.selectedLightIndex,
                            options: addAPlantVM.options1
                        )
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Plant Diameter")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        SegmentControl(
                            selectedIndex: $addAPlantVM.plantDiameterIndex,
                            options: addAPlantVM.options2
                        )
                        
                    }
                    
                    
                }
            }
            .onChange(of: addAPlantVM.selectedItem) { oldItem, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        addAPlantVM.selectedImage = data
                    }
                }
            }
            .padding()
            .navigationTitle("Add New Plant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.blue)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let tempPlant = addAPlantVM.createPlantObject()
                        plantViewModel.addPlant(newPlant: tempPlant)
                        dismiss()
                    } label: {
                        Text("Done")
                            .foregroundStyle(.blue)
                    }
                }
            }
            
        }
        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
    }
}

#Preview {
    NavigationStack {
        AddAPlantView(plantViewModel: DashboardViewModel())
            .environment(ThemeManager())
            .preferredColorScheme(.dark)
            .modelContainer(for: Plant.self)
    }
}
