//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import Foundation

@Observable final class Book: Codable, Identifiable, CustomStringConvertible {
    
    enum CodingKeys: String, CodingKey {
        case id
        case _title = "title"
        case _year = "year"
        case _author = "author"
        case _percentComplete = "percentComplete"
    }
    
    let id: UUID
    var title: String
    var year: String
    var author: String
    var percentComplete: Double
    
    var description: String {
        "\ntitle: \(title), year: \(year), author: \(author)"
    }
}
