//
//  MovieListViewModel.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation

class MovieListViewModel {
    var updateData: (() -> Void)?
    var movies = [Movie]() {
        didSet {
            updateData?()
        }
    }
    
    private var service: MovieService?
    
    init(service: MovieService) {
        self.service = service
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return movies.count
    }
    
    func movieAtIndex(_ index: Int) -> Movie {
        return movies[index]
    }
    
    func fetchMovies(type: MovieType) {
        service?.fetchMovies(type, completion: { [weak self] (movies) in
            DispatchQueue.main.async {
                self?.movies = movies
            }
        })
    }
}
