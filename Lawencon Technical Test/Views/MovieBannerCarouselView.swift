//
//  MovieBannerCarouselView.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 21/02/24.
//

import SwiftUI

struct MovieBannerCarouselView: View {
    let movies: [Movie]
    
    var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(movies) { movie in
                    MovieBannerCard(movie: movie)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MovieBannerCarouselView(movies: Movie.stubbedMovies)
}
