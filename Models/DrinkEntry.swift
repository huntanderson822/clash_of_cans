//
//  DrinkEntry.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import Foundation

struct DrinkEntry: Identifiable, Codable {
    let id: UUID
    let drinkId: String // references Drink.id
    let timestamp: Date
    
    init(id: UUID = UUID(), drinkId: String, timestamp: Date = Date()) {
        self.id = id
        self.drinkId = drinkId
        self.timestamp = timestamp
    }
}

