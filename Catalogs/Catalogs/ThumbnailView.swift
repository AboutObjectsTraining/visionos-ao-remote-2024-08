//
//  Created 8/9/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI

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
