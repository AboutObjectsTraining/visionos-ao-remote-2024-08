//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

struct BooksBrowser: View {
    let viewModel: CatalogsViewModel
    
    var body: some View {
        if !viewModel.hasBooks {
            EmptyContentMessage(title: "No books.", message: "Tap the + button to add a book.")
        } else {
            List(viewModel.bookCatalog.books) { book in
                Text(book.title)
            }
        }
    }
}

