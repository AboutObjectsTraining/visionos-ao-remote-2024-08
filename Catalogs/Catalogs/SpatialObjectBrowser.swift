//
//  Created 8/8/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

struct SpatialObjectsBrowser: View {
    let viewModel: CatalogsViewModel
    
    var body: some View {
        if !viewModel.hasObjects {
            EmptyContentMessage(title: "No 3D models.", message: "Tap the + button to add a 3D model.")            
        } else {
            List(viewModel.objectCatalog.objects) { object in
                Text(object.title)
            }
        }
    }
}
