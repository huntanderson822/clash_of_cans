//
//  Drink.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import Foundation

struct Drink: Identifiable, Codable {
    let id: String
    let brand: String
    let name: String // flavor/variant name
    let caffeineMg: Int
    let assetId: String // matches Assets.xcassets filename
    let barcode: String? // optional UPC/EAN
    
    var fullName: String {
        "\(brand) \(name)"
    }
}

