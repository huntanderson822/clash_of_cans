//
//  CanView.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import SwiftUI

struct CanView: View {
    let assetId: String
    let width: CGFloat
    
    var body: some View {
        Image(assetId)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
            .transition(.scale.combined(with: .opacity))
    }
}

