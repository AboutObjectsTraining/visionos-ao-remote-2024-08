//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import Foundation

final class DataStore {
    let storeName: String
    let storeType = "json"
    
    init(storeName: String = "BookCatalog") {
        self.storeName = storeName
        copyFileIfNecessary()
    }
}

// MARK: - Filesystem Access
extension DataStore {
    
    var demoFileURL: URL {
        Bundle.main.url(forResource: storeName, withExtension: storeType)!
    }
    
    var storeFileURL: URL {
        URL.documentsDirectory
            .appendingPathComponent(storeName)
            .appendingPathExtension(storeType)
    }
    
    private func copyFileIfNecessary() {
        if !FileManager.default.fileExists(atPath: storeFileURL.path) {
            try? FileManager.default.copyItem(at: demoFileURL, to: storeFileURL)
        }
    }
}

// MARK: - Persistence Operations
extension DataStore {
    
    func fetchBookCatalog() async throws -> BookCatalog {
        let (data, _) = try await URLSession.shared.data(from: storeFileURL)
        return try JSONDecoder().decode(BookCatalog.self, from: data)
    }
    
    func fetchSpatialObjectCatalog() async throws -> SpatialObjectCatalog {
        let (data, _) = try await URLSession.shared.data(from: storeFileURL)
        return try JSONDecoder().decode(SpatialObjectCatalog.self, from: data)
    }
}
