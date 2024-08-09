//
//  Created 8/9/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI
import RealityKit

struct SpatialObjectsView: View {
    
    let viewModel: CatalogsViewModel
    
    private let defaultPosition: SIMD3<Float> = [0, 1.5, -1.5]
    
    var body: some View {
        
        RealityView() { content in
            // TODO: Load selected object
            
            if let entity = try? await ModelEntity(named: "Toy Biplane") {
                content.add(entity)
                entity.position = defaultPosition
                entity.scale = entity.scale(relativeTo: nil) * 2
            }
        } placeholder: {
            ProgressView()
        }
    }
}
