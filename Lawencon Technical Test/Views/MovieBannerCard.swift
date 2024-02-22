//
//  MovieBannerCard.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import SwiftUI

struct MovieBannerCard: View {
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                        .scaledToFill()
                        .opacity(0.8)
                        .clipped()
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.2))
                    
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white.opacity(0), Color.black.opacity(0.8)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    
                    HStack {
                        VStack(alignment: .leading) {
                            NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                Text("Detail")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                            
                            Text("\(movie.title) (\(movie.yearText))")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                            
                            if !movie.ratingText.isEmpty {
                                Text(movie.ratingText)
                                    .font(.system(size: 40))
                                    .foregroundColor(.yellow)
                            }
                            
                            Text(movie.scoreText)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top, -40)

                        }
                        .padding()
                    }
                }
            }
            .cornerRadius(8)
            .shadow(radius: 4)
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropURL )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MovieBannerCard(movie: Movie.stubbedMovie)
}
