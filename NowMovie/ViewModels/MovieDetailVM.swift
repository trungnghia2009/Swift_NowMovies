//
//  MovieViewModel.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation

class MovieDetailVM {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var id: Int {
        return movie.id
    }
    
    var title: String {
        return movie.title
    }
    
    var rating: String {
        return "Rating: \(movie.rating)"
    }
    
    var coverImageURL: String {
        return movie.coverImageURL
    }
    
    var detailImageUrl: String {
        return movie.detailImageURL
    }
    
    var overview: String {
        return movie.overview
    }
}
