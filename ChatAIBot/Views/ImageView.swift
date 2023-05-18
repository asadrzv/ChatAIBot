//
//  ImageView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/16/23.
//

import SwiftUI

struct ImageView: View {
    let imageUrl: String
    let dimensions: Double
    
    init(imageUrl: String, dimensions: Double) {
        self.imageUrl = imageUrl
        self.dimensions = dimensions
    }
    
    var body: some View {
        // Use AsyncImage to fetch image from URL and automatically cache it
        AsyncImage(url: URL(string: imageUrl)) { phase in
            // Transaction phase parameter to handle errors loading image
            switch phase {
            // Placeholder loading image
            case .empty:
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
                    .background(.thinMaterial)
            // Valid image
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: dimensions, height: dimensions)
                    .background(.thinMaterial)
            // Error fetching image from url
            case .failure:
                Text("Error: Failed to fetch image")
            // Error unknown
            @unknown default:
                Text("Error: Unknown")
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageUrl: Constants.sampleImageUrl, dimensions: 200)
    }
}
