//
//  DrinkCatalogService.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import Foundation

class DrinkCatalogService {
    static let shared = DrinkCatalogService()
    
    private let drinks: [Drink]
    
    private init() {
        // Curated catalog of popular energy drinks
        self.drinks = [
            // Red Bull
            Drink(id: "redbull_original", brand: "Red Bull", name: "Original", caffeineMg: 80, assetId: "redbull_original", barcode: "790594001004"),
            Drink(id: "redbull_sugarfree", brand: "Red Bull", name: "Sugar Free", caffeineMg: 80, assetId: "redbull_sugarfree", barcode: "790594001035"),
            Drink(id: "redbull_totalzero", brand: "Red Bull", name: "Total Zero", caffeineMg: 80, assetId: "redbull_totalzero", barcode: nil),
            
            // Monster Energy
            Drink(id: "monster_green", brand: "Monster Energy", name: "Original", caffeineMg: 160, assetId: "monster_green", barcode: "0078749300128"),
            Drink(id: "monster_ultra", brand: "Monster Energy", name: "Ultra", caffeineMg: 150, assetId: "monster_ultra", barcode: "0078749300104"),
            Drink(id: "monster_zero", brand: "Monster Energy", name: "Zero Sugar", caffeineMg: 140, assetId: "monster_zero", barcode: "0078749300296"),
            
            // Rockstar
            Drink(id: "rockstar_original", brand: "Rockstar", name: "Original", caffeineMg: 160, assetId: "rockstar_original", barcode: "0722252560115"),
            Drink(id: "rockstar_zero", brand: "Rockstar", name: "Zero Sugar", caffeineMg: 160, assetId: "rockstar_zero", barcode: "0722252560542"),
            
            // Celsius
            Drink(id: "celsius_peach", brand: "Celsius", name: "Peach Vibe", caffeineMg: 200, assetId: "celsius_peach", barcode: "854161007065"),
            Drink(id: "celsius_sparkling", brand: "Celsius", name: "Sparkling Orange", caffeineMg: 200, assetId: "celsius_sparkling", barcode: "854161007058"),
            Drink(id: "celsius_arctic", brand: "Celsius", name: "Arctic Vibe", caffeineMg: 200, assetId: "celsius_arctic", barcode: "854161007072"),
            
            // Bang
            Drink(id: "bang_cotton", brand: "Bang", name: "Cotton Candy", caffeineMg: 300, assetId: "bang_cotton", barcode: "086511212114"),
            Drink(id: "bang_rainbow", brand: "Bang", name: "Rainbow Unicorn", caffeineMg: 300, assetId: "bang_rainbow", barcode: "086511212145"),
            Drink(id: "bang_miami", brand: "Bang", name: "Miami Cola", caffeineMg: 300, assetId: "bang_miami", barcode: nil),
            
            // Reign
            Drink(id: "reign_orange", brand: "Reign", name: "Orange Dreamsicle", caffeineMg: 300, assetId: "reign_orange", barcode: "086511211962"),
            Drink(id: "reign_raze", brand: "Reign", name: "Razzle Berry", caffeineMg: 300, assetId: "reign_raze", barcode: "086511212038"),
            
            // 5-Hour Energy (shot size)
            Drink(id: "5hour_regular", brand: "5-Hour Energy", name: "Regular", caffeineMg: 200, assetId: "5hour_regular", barcode: "0722252690041"),
            Drink(id: "5hour_extra", brand: "5-Hour Energy", name: "Extra Strength", caffeineMg: 230, assetId: "5hour_extra", barcode: "0722252690049"),
            
            // NOS
            Drink(id: "nos_original", brand: "NOS", name: "Original", caffeineMg: 160, assetId: "nos_original", barcode: "0722252560337"),
            Drink(id: "nos_zero", brand: "NOS", name: "Zero", caffeineMg: 160, assetId: "nos_zero", barcode: nil),
            
            // G Fuel
            Drink(id: "gfuel_faze", brand: "G Fuel", name: "Fazeberry", caffeineMg: 150, assetId: "gfuel_faze", barcode: nil),
            Drink(id: "gfuel_peach", brand: "G Fuel", name: "Peach Rings", caffeineMg: 150, assetId: "gfuel_peach", barcode: nil),
            
            // C4 Energy
            Drink(id: "c4_orange", brand: "C4 Energy", name: "Orange Slice", caffeineMg: 200, assetId: "c4_orange", barcode: "860003255057"),
            Drink(id: "c4_berry", brand: "C4 Energy", name: "Arctic Snow Cone", caffeineMg: 200, assetId: "c4_berry", barcode: nil),
            
            // Rockstar Recovery
            Drink(id: "rockstar_recovery", brand: "Rockstar", name: "Recovery", caffeineMg: 160, assetId: "rockstar_recovery", barcode: nil),
            
            // Monster Hydro
            Drink(id: "monster_hydro", brand: "Monster Energy", name: "Hydro", caffeineMg: 125, assetId: "monster_hydro", barcode: nil),
        ]
    }
    
    func getAllDrinks() -> [Drink] {
        return drinks
    }
    
    func findDrink(byId id: String) -> Drink? {
        return drinks.first { $0.id == id }
    }
    
    func searchDrinks(query: String) -> [Drink] {
        guard !query.isEmpty else {
            return drinks
        }
        
        let lowercasedQuery = query.lowercased()
        return drinks.filter { drink in
            drink.brand.lowercased().contains(lowercasedQuery) ||
            drink.name.lowercased().contains(lowercasedQuery) ||
            drink.fullName.lowercased().contains(lowercasedQuery)
        }
    }
    
    func findDrink(byBarcode barcode: String) -> Drink? {
        return drinks.first { drink in
            guard let drinkBarcode = drink.barcode else { return false }
            return drinkBarcode == barcode
        }
    }
}

