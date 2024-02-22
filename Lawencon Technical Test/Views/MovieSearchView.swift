//
//  MovieSearchView.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import SwiftUI

struct MovieSearchView: View {
    @ObservedObject var movieSearchState = MovieSearchState()
    @ObservedObject private var state = MovieListState()
    
    @State var endpoint: MovieListEndpoint?
    @State var page: Int = 1
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                SearchBarView(placeholder: "Search Movies", text: $movieSearchState.query)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                
                LoadingView(isLoading: movieSearchState.isLoading, error: movieSearchState.error) {
                    endpoint = nil
                    movieSearchState.search(query: movieSearchState.query, page: page)
                }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        if movieSearchState.movies != nil {
                            ForEach(movieSearchState.movies!) { movie in
                                NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                    MoviePosterCard(movie: movie)
                                        .frame(height: geometry.size.height * 0.4)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        } else if state.movies != nil {
                            ForEach(state.movies!) { movie in
                                NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                                    MoviePosterCard(movie: movie)
                                        .frame(height: geometry.size.height * 0.4)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
            .onAppear {
                movieSearchState.query = ""
                page = 1
                
                if endpoint != nil {
                    state.loadMovies(with: endpoint!, page: page)
                }
                
                movieSearchState.startObserve(page: page)
            }
            .refreshable {
                page += 1
                
                if endpoint != nil {
                    state.loadMovies(with: endpoint!, page: page)
                }
                
                movieSearchState.startObserve(page: page)
                movieSearchState.search(query: movieSearchState.query, page: page)
                
            }
            .padding(.top, geometry.size.height * 0.1)
            .padding()
        }
        .ignoresSafeArea()
    }
    
    func loadMore() {
        page += 1
        
        if endpoint != nil {
            state.loadMovies(with: endpoint!, page: page)
        }
        
        movieSearchState.startObserve(page: page)
        movieSearchState.search(query: movieSearchState.query, page: page)
    }
}

#Preview {
    MovieSearchView()
}
