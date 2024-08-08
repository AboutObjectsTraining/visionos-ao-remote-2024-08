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
    
    var isAddingBook = false
    
    var hasBooks: Bool {
        !bookCatalog.books.isEmpty
    }
}

// MARK: Actions
extension CatalogsViewModel {
    
    func beginAddingBook() {
        isAddingBook = true
    }
    
    func addBook(_ book: Book) {
        isAddingBook = false
        bookCatalog.add(book: book)
        // TODO: Save changes...
    }
    
    func cancelAddBook() {
        isAddingBook = false
    }
    
    func removeBooks(atOffsets offsets: IndexSet) {
        bookCatalog.remove(atOffsets: offsets)
        // TODO: Save changes...
    }
    
    func moveBooks(atOffsets offsets: IndexSet, toOffset offset: Int) {
        bookCatalog.move(fromOffsets: offsets, toOffset: offset)
        // TODO: Save changes...
    }
    
    func loadBooks() async {
        do {
            bookCatalog = try await bookCatalogDataStore.fetchBookCatalog()
        } catch {
            print("Unable to fetch BookCatalog from \(bookCatalogDataStore) due to \(error)")
        }
    }
}
