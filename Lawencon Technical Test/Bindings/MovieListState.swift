//
//  MovieListState.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import Foundation
import SwiftUI

class MovieListState: ObservableObject {
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shered) {
        self.movieService = movieService
    }
    
    func loadMovies(with endpoint: MovieListEndpoint, max: Int? = nil, page: Int? = 1) {
        self.movies = nil
        self.isLoading = false
        self.movieService.fetchMovies(from: endpoint, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response): 
                if max != nil {
                    self.movies = Array(response.results.prefix(max!))
                } else {
                    self.movies = response.results
                }
            case .failure(let error): self.error = error as NSError
            }
        }
    }
}
