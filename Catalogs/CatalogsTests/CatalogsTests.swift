//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import XCTest
@testable import Catalogs

class CatalogsTests: XCTestCase {
    
    func testFetchBookCatalog() async throws {
        let store = DataStore()
        let bookCatalog = try await store.fetchBookCatalog()
        print(bookCatalog)
    }
}