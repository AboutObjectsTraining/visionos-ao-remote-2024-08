//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

struct ContentView: View {
    @Bindable var viewModel: CatalogsViewModel
    
    var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.selectedTab) {
                BooksBrowser(viewModel: viewModel)
                    .tag(Tab.books)
                    .tabItem {
                        Label(Tab.books.rawValue, systemImage: "books.vertical.fill" )
                    }
                    .onAppear {
                        if !viewModel.hasBooks {
                            Task {
                                await viewModel.loadBooks()
                            }
                        }
                    }
                SpatialObjectsBrowser()
                    .tag(Tab.objects)
                    .tabItem {
                        Label(Tab.objects.rawValue, systemImage: "rotate.3d.fill")
                    }
                SettingsBrowser()
                    .tag(Tab.settings)
                    .tabItem {
                        Label(Tab.settings.rawValue, systemImage: "gear")
                    }
            }
            .navigationTitle(
                viewModel.selectedTab.rawValue
            )
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

struct SpatialObjectsBrowser: View {
    
    var body: some View {
        EmptyContentMessage(title: "No 3D models.", message: "Tap the + button to add a 3D model.")
    }
}

struct SettingsBrowser: View {
    
    var body: some View {
        EmptyContentMessage(title: "No Settings", message: "This feature is coming soon!")
    }
}

#Preview("Content View",
         windowStyle: .automatic,
         traits: .fixedLayout(width: 400, height: 600)) {
    
    ContentView(viewModel: CatalogsViewModel())
}
