//
//  Created 8/8/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

struct BookDetail: View {
    @Environment(\.editMode) var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }
    
    @Bindable var book: Book
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        Form {
            Section {
                TitledCell(title: "Title", value: $book.title)
                    .focused($isFocused)
                TitledCell(title: "Year", value: $book.year)
            } header: {
                Label("Book", systemImage: "book")
            }
            Section {
                TitledCell(title: "Author", value: $book.author)
            } header: {
                Label("Author", systemImage: "person")
            }
            Section {
                percentCompleteView
            } header: {
                Label("Progress", systemImage: "chart.line.flattrend.xyaxis")
            }
            Section {
                coverImage
            } header: {
                Label("Cover", systemImage: "book.closed")
            }
        }
        .navigationTitle("Book Detail")
        .toolbar {
            EditButton()
        }
        .onChange(of: isEditing) {
            isFocused = isEditing
            // TODO: Save changes...
            // TODO: Unwind to list
        }
    }
}

extension BookDetail {
    
    private var percentCompleteView: some View {
        VStack(alignment: .leading) {
            Text("Percent Complete")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(book.percentComplete, format: .percent)
            
            if isEditing {
                Slider(value: $book.percentComplete,
                       in: 0.0...1.0,
                       step: 0.1) {
                    Text("Percent Complete")
                }
            }
        }
    }
    
    private var coverImage: some View {
        HStack {
            Spacer()
            AsyncImage(url: book.artworkURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "photo")
                    .imageScale(.large)
                    .font(.system(size: 96))
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

struct TitledCell: View {
    @Environment(\.editMode) var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing ?? false
    }

    let title: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.bottom, isEditing ? -6 : 0)
                .padding(.top, 4)
            
            if isEditing {
                TextField(text: $value) { }
            } else {
                Text(value)
            }
        }
    }
}

#Preview("Book Detail",
         windowStyle: .automatic,
         traits: .fixedLayout(width: 600, height: 600)) {
    
    BookDetail(book: Book(title: "1984", year: "1999", author: "H. G. Wells"))
}

#Preview("Book Detail w/Missing Image",
         windowStyle: .automatic,
         traits: .fixedLayout(width: 600, height: 600)) {
    
    BookDetail(book: Book(title: "Foobar", year: "1999", author: "H. G. Wells"))
}
