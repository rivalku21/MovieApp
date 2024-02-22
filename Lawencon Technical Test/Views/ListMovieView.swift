//
//  ListMovieView.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import SwiftUI

struct ListMovieView: View {
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        ZStack(alignment: .top) {
                            Group {
                                if popularState.movies != nil {
                                    MovieBannerCarouselView(movies: popularState.movies!)
                                        .frame(height: geometry.size.height * 0.4)
                                } else {
                                    LoadingView(isLoading: popularState.isLoading, error: popularState.error) {
                                        popularState.loadMovies(with: .popular)
                                    }
                                }
                            }
                            
                            HStack {
                                NavigationLink(destination: MovieSearchView()) {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 20)
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                Button {
                                    UserDefaults.standard.removeObject(forKey: "username")
                                    UserDefaults.standard.removeObject(forKey: "password")
                                    isLoggedIn = false
                                } label: {
                                    Text("Logout")
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, geometry.size.height * 0.1)
                        }
                        
                        Group {
                            if nowPlayingState.movies != nil {
                                MoviePosterCarouselView(title: "Now Playing", movies: nowPlayingState.movies!, endpoint: .nowPlaying)
                                    .frame(height: geometry.size.height * 0.4)
                            } else {
                                LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                                    self.nowPlayingState.loadMovies(with: .nowPlaying)
                                }
                            }
                        }
                        
                        Group {
                            if upcomingState.movies != nil {
                                MovieBackDropCarouselView(title: "Upcoming", movies: upcomingState.movies!, endpoint: .upcoming)
                                    .frame(height: geometry.size.height * 0.3)
                            } else {
                                LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                                    self.upcomingState.loadMovies(with: .upcoming)
                                }
                            }
                        }
                        
                        Group {
                            if topRatedState.movies != nil {
                                MovieBackDropCarouselView(title: "Top Rated", movies: topRatedState.movies!, endpoint: .topRated)
                                    .frame(height: geometry.size.height * 0.3)
                            } else {
                                LoadingView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                                    self.topRatedState.loadMovies(with: .topRated)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
                .ignoresSafeArea()
            }
            .refreshable {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.nowPlayingState.loadMovies(with: .nowPlaying, max: 7)
                    self.upcomingState.loadMovies(with: .upcoming, max: 7)
                    self.topRatedState.loadMovies(with: .topRated, max: 7)
                    self.popularState.loadMovies(with: .popular, max: 5)
                }
            }
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying, max: 7)
            self.upcomingState.loadMovies(with: .upcoming, max: 7)
            self.topRatedState.loadMovies(with: .topRated, max: 7)
            self.popularState.loadMovies(with: .popular, max: 5)
        }
    }
}

#Preview {
    ListMovieView(isLoggedIn: .constant(true))
}
