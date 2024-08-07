//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import Foundation

@Observable final class BookCatalog: Codable, Identifiable, CustomStringConvertible {
    
    enum CodingKeys: String, CodingKey {
        case id
        case _title = "title"
        case _books = "books"
    }
    
    let id: UUID
    var title: String
    var books: [Book]
    
    var description: String {
        "title: \(title), books: \(books)"
    }
    
    init(title: String, books: [Book]) {
        self.id = UUID()
        self.title = title
        self.books = books
    }
}
