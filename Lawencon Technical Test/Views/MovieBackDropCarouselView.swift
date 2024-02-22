//
//  MovieBackDropCarouselView.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import SwiftUI

struct MovieBackDropCarouselView: View {
    let title: String
    let movies: [Movie]
    var endpoint: MovieListEndpoint?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    
                    NavigationLink(destination: MovieSearchView(endpoint: endpoint)) {
                        Text("View All")
                    }
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(self.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                MovieBackDropCard(movie: movie)
                                    .frame(width: geometry.size.width * 0.5)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MovieBackDropCarouselView(title: "Latest", movies: Movie.stubbedMovies)
}
