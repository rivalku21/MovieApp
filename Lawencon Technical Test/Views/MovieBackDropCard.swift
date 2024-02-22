//
//  MovieBackDropCard.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import SwiftUI

struct MovieBackDropCard: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Text(movie.title)
            
            if !movie.ratingText.isEmpty {
                Text(movie.ratingText)
                    .font(.system(size: 30))
                    .foregroundColor(.yellow)
            }
        }
        .lineLimit(1)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropURL )
        }
    }
}

#Preview {
    MovieBackDropCard(movie: Movie.stubbedMovie)
}
