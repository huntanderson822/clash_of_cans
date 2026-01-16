//
//  HeaderView.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import SwiftUI

struct HeaderView: View {
    let totalDrinks: Int
    let totalCaffeine: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(totalDrinks) drinks")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("\(totalCaffeine) mg caffeine")
                .font(.title3)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
    }
}

