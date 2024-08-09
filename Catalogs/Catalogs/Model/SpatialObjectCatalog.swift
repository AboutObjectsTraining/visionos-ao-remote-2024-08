//
//  Created 8/8/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import Foundation

@Observable final class SpatialObjectCatalog: Codable, Identifiable, CustomStringConvertible {
    
    enum CodingKeys: String, CodingKey {
        case id
        case _title = "title"
        case _objects = "objects"
    }
    
    let id: UUID
    var title: String
    var objects: [SpatialObject]
    
    var description: String {
        "title: \(title), objects: \(objects)"
    }
    
    init(id: UUID = UUID(), title: String, objects: [SpatialObject]) {
        self.id = id
        self.title = title
        self.objects = objects
    }
}
