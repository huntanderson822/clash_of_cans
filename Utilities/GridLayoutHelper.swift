//
//  GridLayoutHelper.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import SwiftUI

struct GridLayoutHelper {
    static func columnCount(for width: CGFloat) -> Int {
        // 5 columns for iPhone, 6 for iPad or larger screens
        if width > 768 { // iPad
            return 6
        }
        return 5
    }
    
    static func canWidth(for screenWidth: CGFloat, columns: Int, padding: CGFloat = 16, gap: CGFloat = 2) -> CGFloat {
        let totalPadding = padding * 2
        let totalGaps = gap * CGFloat(columns - 1)
        return (screenWidth - totalPadding - totalGaps) / CGFloat(columns)
    }
    
    static func offset(for row: Int, columnWidth: CGFloat) -> CGFloat {
        // Stagger every other row by ~20% of column width
        if row % 2 == 1 {
            return columnWidth * 0.2
        }
        return 0
    }
    
    static func verticalSpacing() -> CGFloat {
        // Negative spacing for stacked effect
        return -15
    }
}

