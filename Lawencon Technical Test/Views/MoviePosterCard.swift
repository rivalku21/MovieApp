//
//  MoviePosterCard.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import SwiftUI

struct MoviePosterCard: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ZStack {
                    if self.imageLoader.image != nil {
                        Image(uiImage: self.imageLoader.image!)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                            .shadow(radius: 4)
                        
                    }
                }
                
                Text(movie.title)
                    .lineLimit(1)
                
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText)
                        .foregroundColor(.yellow)
                } else {
                    Text("n/a")
                }
            }
            .onAppear {
                self.imageLoader.loadImage(with: self.movie.posterURL)
            }
        }
    }
}

#Preview {
    MoviePosterCard(movie: Movie.stubbedMovie)
}
