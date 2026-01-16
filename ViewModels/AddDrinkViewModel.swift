//
//  AddDrinkViewModel.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

@MainActor
class AddDrinkViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredDrinks: [Drink] = []
    @Published var showingUnsupportedAlert: Bool = false
    @Published var showingRequestDialog: Bool = false
    
    private let catalogService = DrinkCatalogService.shared
    
    init() {
        filteredDrinks = catalogService.getAllDrinks()
    }
    
    func searchDrinks(query: String) {
        searchText = query
        if query.isEmpty {
            filteredDrinks = catalogService.getAllDrinks()
        } else {
            filteredDrinks = catalogService.searchDrinks(query: query)
        }
    }
    
    func handleBarcodeScan(_ barcode: String) -> Drink? {
        return catalogService.findDrink(byBarcode: barcode)
    }
    
    func showUnsupportedMessage() {
        showingUnsupportedAlert = true
    }
    
    func requestDrink() {
        showingRequestDialog = true
    }
}

