//
//  WallView.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import SwiftUI

struct WallView: View {
    @ObservedObject var viewModel: WallViewModel
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    init(viewModel: WallViewModel) {
        self.viewModel = viewModel
    }
    
    private var columns: Int {
        GridLayoutHelper.columnCount(for: screenWidth)
    }
    
    private var canWidth: CGFloat {
        GridLayoutHelper.canWidth(for: screenWidth, columns: columns)
    }
    
    private var gridItems: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 2), count: columns)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    HeaderView(
                        totalDrinks: viewModel.totalDrinks,
                        totalCaffeine: viewModel.totalCaffeine
                    )
                    
                    if viewModel.entries.isEmpty {
                        EmptyStateView()
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                    } else {
                        LazyVGrid(columns: gridItems, spacing: GridLayoutHelper.verticalSpacing()) {
                            ForEach(Array(viewModel.entries.enumerated()), id: \.element.id) { index, entry in
                                if let drink = DrinkCatalogService.shared.findDrink(byId: entry.drinkId) {
                                    CanView(assetId: drink.assetId, width: canWidth)
                                        .offset(x: GridLayoutHelper.offset(for: index / columns, columnWidth: canWidth))
                                        .id(entry.id)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.entries.count)
                    }
                }
            }
            .onAppear {
                screenWidth = geometry.size.width
            }
            .onChange(of: geometry.size.width) { newWidth in
                screenWidth = newWidth
            }
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "can.fill")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("No drinks logged yet")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("Tap the + button to add your first drink")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

