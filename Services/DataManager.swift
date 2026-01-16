//
//  DataManager.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let entriesFileName = "entries.json"
    
    private var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var entriesFileURL: URL {
        documentsDirectory.appendingPathComponent(entriesFileName)
    }
    
    private init() {}
    
    func loadEntries() -> [DrinkEntry] {
        guard FileManager.default.fileExists(atPath: entriesFileURL.path) else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: entriesFileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let entries = try decoder.decode([DrinkEntry].self, from: data)
            return entries
        } catch {
            print("Error loading entries: \(error)")
            return []
        }
    }
    
    func saveAllEntries(_ entries: [DrinkEntry]) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let data = try encoder.encode(entries)
            try data.write(to: entriesFileURL, options: [.atomic])
        } catch {
            print("Error saving entries: \(error)")
        }
    }
    
    func saveEntry(_ entry: DrinkEntry) {
        var entries = loadEntries()
        entries.append(entry)
        saveAllEntries(entries)
    }
}

