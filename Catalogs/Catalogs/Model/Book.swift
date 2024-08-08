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
    
    var artworkURL: URL {
        let title = title.isEmpty ? "unknown" : title
        let path = Bundle.main.path(forResource: title, ofType: "jpg")
        return URL(fileURLWithPath: path ?? "")
    }
    
    var description: String {
        "\ntitle: \(title), year: \(year), author: \(author)"
    }
    
    init(id: UUID = UUID(), title: String = "", year: String = "", author: String = "", percentComplete: Double = 0.0) {
        self.id = id
        self.title = title
        self.year = year
        self.author = author
        self.percentComplete = percentComplete
    }
}
