//
//  Created 8/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

@main
struct CatalogsApp: App {
    
    @State private var viewModel = CatalogsViewModel()
    
    static let spatialObjects = "Spatial Objects"
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .frame(minWidth: 600, maxWidth: 1000, minHeight: 500)
        }
        .defaultSize(width: 640, height: 960)
        .windowResizability(.contentSize)
        
        ImmersiveSpace(id: Self.spatialObjects) {
            SpatialObjectsView(viewModel: viewModel)
        }
    }
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
}
