//
//  Created 8/8/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import Foundation

@Observable final class SpatialObject: Codable, Identifiable, CustomStringConvertible {
    
    enum CodingKeys: String, CodingKey {
        case id
        case _title = "title"
    }
    
    let id: UUID
    var title: String
    
    var description: String {
        "\ntitle: \(title)"
    }
    
    var artworkURL: URL {
        let title = title.isEmpty ? "unknown" : title
        let path = Bundle.main.path(forResource: title, ofType: "png")
        return URL(fileURLWithPath: path ?? "")
    }
}
