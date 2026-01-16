//
//  ContentView.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var wallViewModel = WallViewModel()
    @State private var showingAddDrink = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                WallView(viewModel: wallViewModel)
                    .navigationTitle("Clash of Cans")
                    .navigationBarTitleDisplayMode(.inline)
                
                Button(action: {
                    showingAddDrink = true
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }
            .sheet(isPresented: $showingAddDrink) {
                AddDrinkView(wallViewModel: wallViewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}

