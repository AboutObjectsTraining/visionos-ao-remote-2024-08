//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            BooksBrowser()
                .tabItem {
                    Label("Books", systemImage: "books.vertical.fill" )
                }
            SpatialObjectsBrowser()
                .tabItem {
                    Label("3D Models", systemImage: "rotate.3d.fill")
                }
        }
    }
}

struct EmptyContentMessage: View {
    let title: String
    let message: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(message)
                .font(.subheadline)
        }
    }
}

struct BooksBrowser: View {
    
    var body: some View {
        EmptyContentMessage(title: "No books.", message: "Tap the + button to add a book.")
    }
}

struct SpatialObjectsBrowser: View {
    
    var body: some View {
        EmptyContentMessage(title: "No 3D models.", message: "Tap the + button to add a 3D model.")
    }
}

#Preview("Content View",
         windowStyle: .automatic,
         traits: .fixedLayout(width: 400, height: 600)) {
    
    ContentView()
}
