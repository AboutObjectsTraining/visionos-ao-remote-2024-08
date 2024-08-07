//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

enum Tab: String {
    case books = "Books"
    case objects = "3D Models"
    case settings = "Settings"
}

@Observable final class CatalogsViewModel {
    
    private let bookCatalogDataStore = DataStore()
    private(set) var bookCatalog = BookCatalog(title: "Empty", books: [])
    
    var selectedTab = Tab.books
    
    var hasBooks: Bool {
        !bookCatalog.books.isEmpty
    }
}

// MARK: Actions
extension CatalogsViewModel {
    
    func loadBooks() async {
        do {
            bookCatalog = try await bookCatalogDataStore.fetchBookCatalog()
        } catch {
            print("Unable to fetch BookCatalog from \(bookCatalogDataStore) due to \(error)")
        }
    }
}
