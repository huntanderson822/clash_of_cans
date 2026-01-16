//
//  WallViewModel.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

@MainActor
class WallViewModel: ObservableObject {
    @Published var entries: [DrinkEntry] = []
    @Published var totalDrinks: Int = 0
    @Published var totalCaffeine: Int = 0
    
    private let dataManager = DataManager.shared
    private let catalogService = DrinkCatalogService.shared
    
    init() {
        loadEntries()
    }
    
    func loadEntries() {
        entries = dataManager.loadEntries()
        refreshTotals()
    }
    
    func refreshTotals() {
        totalDrinks = entries.count
        
        totalCaffeine = entries.compactMap { entry in
            catalogService.findDrink(byId: entry.drinkId)?.caffeineMg
        }.reduce(0, +)
    }
    
    func addEntry(drinkId: String) {
        let entry = DrinkEntry(drinkId: drinkId)
        entries.append(entry)
        dataManager.saveEntry(entry)
        refreshTotals()
    }
}

