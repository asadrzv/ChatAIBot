//
//  ImageView.swift
//  ChatAIBot
//
//  Created by Asad Rizvi on 5/16/23.
//

import SwiftUI

struct ImageView: View {
    let imageUrl: String
    let dimensions: Double // REPLACE HARDCODED DIMENSIONS WITH DYNAMIC SIZING
    
    // Specify animation between phase changes
    private let transaction: Transaction = .init(animation: .linear)
        
    init(imageUrl: String, dimensions: Double) {
        self.imageUrl = imageUrl
        self.dimensions = dimensions
    }
    
    var body: some View {
        // Use AsyncImage to fetch image from URL and automatically cache it
        AsyncImage(url: URL(string: imageUrl), transaction: transaction) { phase in
            // Transaction phase parameter to handle errors loading image
            switch phase {
            // Placeholder loading image
            case .empty:
                ProgressView()
            // Valid image
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            // Error fetching image from url
            case .failure:
                Text("⚠️ Oh no! I can't find the image you're looking for 🖼️")
                    .multilineTextAlignment(.center)
            // Error unknown
            @unknown default:
                Text("Not sure what happened 😕. Try restarting the app.")
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: dimensions, height: dimensions)
        .background(.thinMaterial)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        // Empty image URL
        ImageView(imageUrl: "", dimensions: 200)
        // Successfully fetched image
        ImageView(imageUrl: Constants.sampleImageURL, dimensions: 200)
        // Error fetching image from URL
        ImageView(imageUrl: "error", dimensions: 200)
    }
}
