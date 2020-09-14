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
    
    private var service: MovieServiceProtocol?
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return movies.count
    }
    
    func movieAtIndex(_ index: Int) -> Movie {
        return movies[index]
    }
    
    func fetchMovies(type: MovieType) {
        service?.fetchMovies(type, completion: { [weak self] (result) in
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(let error):
                print(error)
            }
        })
    }
}
