//
//  Created 8/8/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

struct SpatialObjectCell: View {
    let object: SpatialObject
    
    var body: some View {
        ZStack {
            HStack {
                ThumbnailView(artworkURL: object.artworkURL, width: 100)
                Spacer()
                Text(object.title)
            }
            .padding()
            .padding(.horizontal, 12)
        }
        .background(.regularMaterial)
        .hoverEffect()
    }
}

struct SpatialObjectsBrowser: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    let viewModel: CatalogsViewModel
    
    var body: some View {
        Group {
            if !viewModel.hasObjects {
                EmptyContentMessage(title: "No 3D models.", message: "Tap the + button to add a 3D model.")
            } else {
                List {
                    ForEach(viewModel.objectCatalog.objects) { object in
                        SpatialObjectCell(object: object)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }
        .toolbar {
            if viewModel.selectedTab == .objects {
                ToolbarItemGroup(placement: .navigation) {
                    EditButton()
                    Text("\(viewModel.objectsCount) items")
                        .font(.headline)
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: toggleImmersiveSpace) {
                        Text("Immersive Space")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    
    @MainActor private func toggleImmersiveSpace() {
        Task {
            if viewModel.isShowingImmersiveSpace {
                viewModel.isShowingImmersiveSpace = false
                await dismissImmersiveSpace()
            } else {
                viewModel.isShowingImmersiveSpace = true
                await openImmersiveSpace(id: CatalogsApp.spatialObjects)
            }
        }
    }
}