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
    
    private let bookCatalogDataStore = DataStore(storeName: "BookCatalog")
    private(set) var bookCatalog = BookCatalog(title: "Empty", books: [])
    
    private let objectsDataStore = DataStore(storeName: "ObjectCatalog")
    private(set) var objectCatalog = SpatialObjectCatalog(title: "Empty", objects: [])
    
    var selectedTab = Tab.books
    
    var isAddingBook = false
    
    var hasBooks: Bool {
        !bookCatalog.books.isEmpty
    }
    
    var hasObjects: Bool {
        !objectCatalog.objects.isEmpty
    }
}

// MARK: Object Catalog Actions
extension CatalogsViewModel {
    func loadObjects() {
        Task {
            do {
                objectCatalog = try await objectsDataStore.fetchSpatialObjectCatalog()
            } catch {
                print("Unable to fetch \(SpatialObjectCatalog.self) from \(objectsDataStore) due to \(error)")
            }
        }
    }
}

// MARK: Book Catalog Actions
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
            print("Unable to fetch \(BookCatalog.self) from \(bookCatalogDataStore) due to \(error)")
        }
    }
}
