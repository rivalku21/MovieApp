//
//  MovieSearchState.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import Foundation
import Combine
import SwiftUI

class MovieSearchState: ObservableObject {
    @Published var query = ""
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private var subsriptionToken: AnyCancellable?
    
    let movieService: MovieService
    
    init (movieService: MovieService = MovieStore.shered) {
        self.movieService = movieService
    }
    
    func startObserve(page: Int?) {
        guard subsriptionToken == nil else { return }
        
        self.subsriptionToken = self.$query
            .map { [weak self] text in
            self?.movies = nil
            self?.error = nil
            return text
            }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink{ [weak self] in self?.search(query: $0, page: page) }
    }
    
    func search(query: String, page: Int?) {
        self.movies = nil
        self.isLoading = false
        self.error = nil
        
        guard query.count >= 3 else { return }
        
        self.isLoading = true
        self.movieService.searchMovie(query: query, page: page) { [weak self] (result) in
            guard let self = self, self.query == query else { return }
            
            self.isLoading = false
            switch result {
            case .success(let response): self.movies = response.results
            case .failure(let error): self.error = error as NSError
            }
        }
    }
    
    deinit {
        self.subsriptionToken?.cancel()
        self.subsriptionToken = nil
    }
}
