//
//  AddDrinkView.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import SwiftUI

struct AddDrinkView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddDrinkViewModel()
    @State private var showingBarcodeScanner = false
    @State private var requestDrinkText = ""
    @ObservedObject var wallViewModel: WallViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if !viewModel.filteredDrinks.isEmpty {
                    List(viewModel.filteredDrinks) { drink in
                        Button(action: {
                            wallViewModel.addEntry(drinkId: drink.id)
                            dismiss()
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(drink.fullName)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text("\(drink.caffeineMg) mg caffeine")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Search drinks")
                    .onChange(of: viewModel.searchText) { newValue in
                        viewModel.searchDrinks(query: newValue)
                    }
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        
                        Text("No drinks found")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        if !viewModel.searchText.isEmpty {
                            Text("Try a different search")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Button("Request this drink") {
                                viewModel.requestDrink()
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.top, 8)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Add Drink")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingBarcodeScanner = true
                    }) {
                        Image(systemName: "barcode.viewfinder")
                    }
                }
            }
            .sheet(isPresented: $showingBarcodeScanner) {
                BarcodeScannerView(
                    onBarcodeScanned: { barcode in
                        if let drink = viewModel.handleBarcodeScan(barcode) {
                            wallViewModel.addEntry(drinkId: drink.id)
                            showingBarcodeScanner = false
                            dismiss()
                        } else {
                            showingBarcodeScanner = false
                            viewModel.showUnsupportedMessage()
                        }
                    },
                    onDismiss: {
                        showingBarcodeScanner = false
                    }
                )
            }
            .alert("Drink Not Supported", isPresented: $viewModel.showingUnsupportedAlert) {
                Button("Request This Drink") {
                    viewModel.requestDrink()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This drink isn't in our catalog yet. Would you like to request it?")
            }
            .alert("Request Drink", isPresented: $viewModel.showingRequestDialog) {
                TextField("Drink name", text: $requestDrinkText)
                Button("Submit") {
                    // In a real app, this would send feedback
                    // For MVP, we'll just dismiss
                    requestDrinkText = ""
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Tell us which drink you'd like to see added.")
            }
        }
    }
}

