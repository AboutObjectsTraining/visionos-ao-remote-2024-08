//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

struct BooksBrowser: View {
    let viewModel: CatalogsViewModel
    
    var body: some View {
        Group {
            if !viewModel.hasBooks {
                EmptyContentMessage(title: "No books.", message: "Tap the + button to add a book.")
            } else {
                List(viewModel.bookCatalog.books) { book in
                    BookCell(book: book)
                }
            }
        }
    }
}

struct BookCell: View {
    let book: Book
    
    private var bookInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(book.title)
                .font(.headline)
            Text("\(book.year)  \(book.author)")
                .font(.subheadline)
        }
    }
    
    var body: some View {
        HStack(spacing: 18) {
            ThumbnailView(artworkURL: book.artworkURL, width: 70)
            bookInfo
            Spacer()
            ProgressView(value: book.percentComplete)
                .progressViewStyle(CompletionProgressViewStyle())
        }
    }
}

struct ThumbnailView: View {
    let artworkURL: URL
    let width: CGFloat
    
    var placeholder: some View {
        ZStack {
            Rectangle()
                .fill(.regularMaterial)
            Image(systemName: "photo")
                .imageScale(.large)
        }
    }
    
    var body: some View {
        AsyncImage(url: artworkURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if phase.error == nil {
                ProgressView()
            } else {
                placeholder
            }
        }
        .frame(width: width, height: 100)
        .cornerRadius(5)
    }
}

#Preview("Cell") {
    BookCell(book: Book(title: "Foo", year: "1999", author: "Fred Smith"))
        .padding(30)
        .frame(width: 400)
        .glassBackgroundEffect()
}

#Preview("List", windowStyle: .automatic, traits: .fixedLayout(width: 400, height: 600)) {
    
    let viewModel = CatalogsViewModel()
    
    BooksBrowser(viewModel: viewModel)
        .onAppear {
            if !viewModel.hasBooks {
                Task {
                    await viewModel.loadBooks()
                }
            }
        }
}
