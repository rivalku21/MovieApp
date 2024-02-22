//
//  MovieDetailView.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
            }
        }
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    let movie: Movie
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                ZStack(alignment: .bottom) {
                    MovieDetailImage(imageURL: movie.backdropURL)
                        .frame(height: geometry.size.height * 0.4)
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.2))
                    
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white.opacity(0), Color.black.opacity(0.8)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    
                    VStack(spacing: 16) {
                        Text(movie.title)
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Text("\(movie.yearText) - \(movie.genreText) - \(movie.durationText)")
                        
                        Text(movie.ratingText)
                            .font(.system(size: 40))
                            .foregroundColor(.yellow)
                    }
                    .padding()
                }
                .frame(height: geometry.size.height * 0.4)
                
                Text(movie.overview)
                    .padding()
                    .multilineTextAlignment(.center)
                
                HStack(alignment: .top, spacing: 4) {
                    if movie.cast != nil && movie.cast!.count > 0 {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Starring :").font(.headline)
                            ForEach(self.movie.cast!.prefix(9)) { cast in
                                Text(cast.name)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    
                    if movie.crew != nil && movie.crew!.count > 0 {
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading) {
                                if movie.directors != nil && movie.directors!.count > 0 {
                                    Text("Director(s) :")
                                        .font(.headline)
                                    ForEach(self.movie.directors!.prefix(2)) { crew in
                                        Text(crew.name)
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                if movie.producers != nil && movie.producers!.count > 0 {
                                    Text("Producer(s) :")
                                        .font(.headline)
                                    ForEach(self.movie.producers!.prefix(2)) { crew in
                                        Text(crew.name)
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                                    Text("Screenwriter(s) :")
                                        .font(.headline)
                                    ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                        Text(crew.name)
                                    }
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            .foregroundColor(.white)
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}

struct MovieDetailImage: View {
    @ObservedObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle().fill(Color.gray.opacity(0.3))
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width)
                        .scaledToFill()
                        .opacity(0.8)
                }
            }
            .cornerRadius(8)
    //        .aspectRatio(contentMode: .fit)
            .onAppear {
                self.imageLoader.loadImage(with: self.imageURL)
            }
        }
    }
}

#Preview {
    MovieDetailView(movieId: Movie.stubbedMovie.id)
}
