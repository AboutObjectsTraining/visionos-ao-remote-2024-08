//
//  Created 8/9/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI
import RealityKit

struct SpatialObjectsView: View {
    
    let viewModel: CatalogsViewModel
    
    @State private var baseTransform: Transform?
    
    private let defaultPosition: SIMD3<Float> = [0, 1.5, -1.5]
    
    var body: some View {
        
        RealityView { content in
            // No default content
        } update: { content in
            if let entity = loadSelectedObject() {
                content.add(entity)
            } else {
                print("Unable to load entity named \(viewModel.selectedObject?.title ?? "null")")
            }
        } placeholder: {
            ProgressView()
        }
        .gesture(dragGesture)
    }
    
    private func loadSelectedObject() -> Entity? {
        let name = viewModel.selectedObject?.title
        
        guard let entity = try? Entity.load(named: name ?? "") else {
            return nil
        }
        
        entity.position = defaultPosition
        entity.scale = entity.scale(relativeTo: nil) * 2
        
        // Enables gesture recognition
        entity.generateCollisionShapes(recursive: true)
        entity.components.set(InputTargetComponent())
        
        return entity
    }
}

// MARK: Gesture Support
extension SpatialObjectsView {
    
    var dragGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                let entity = value.entity
                if baseTransform == nil {
                    baseTransform = entity.transform
                }
                
                if let parent = entity.parent,
                   let baseTransform = baseTransform {
                    
                    let translation = value.convert(value.translation3D, from: .local, to: parent)
                    entity.transform.translation = baseTransform.translation + translation
                }
            }
            .onEnded { _ in
                baseTransform = nil
            }
    }
    
    var tapGesture: some Gesture {
        TapGesture()
            .targetedToAnyEntity()
            .onEnded { value in
                print("Got tap gesture.")
            }
    }
}
