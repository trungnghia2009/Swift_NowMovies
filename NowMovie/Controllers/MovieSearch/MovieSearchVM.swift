//
//  MovieSearchVM.swift
//  NowMovie
//
//  Created by trungnghia on 9/15/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation
import ReactiveSwift

class MovieSearchVM {
    
    private var disposes = CompositeDisposable()
    private(set) var movies = MutableProperty<[Movie]>([])
    private var service: MovieServiceProtocol?
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return movies.value.count
    }
    
    func movieAtIndex(_ index: Int) -> Movie {
        return movies.value[index]
    }
    
    func searchMovies(searchKey: String) {
        disposes += service?.searchMovies(searchKey)
            .observe(on: UIScheduler())
            .startWithResult{ [weak self] (result) in
                switch result {
                case .success(let movies):
                    self?.movies.value = movies
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func clearObservation() {
        disposes.dispose()
    }
    
}
