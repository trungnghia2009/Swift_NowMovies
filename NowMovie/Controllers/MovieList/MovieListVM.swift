//
//  MovieListViewModel.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation
import ReactiveSwift

class MovieListVM {
    
    private var disposes = CompositeDisposable()
    private(set) var movies = MutableProperty<[Movie]>([])
    private var service: MovieServiceProtocol?
    private(set) var isPaginating = true
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return movies.value.count
    }
    
    func movieAtIndex(_ index: Int) -> Movie {
        return movies.value[index]
    }
    
    func setIsPaginating(value: Bool) {
        isPaginating = value
    }
    
    func fetchMovies(type: MovieType) {
        service?.currentMoviePage = 1
        disposes += service?.fetchMovies(type)
            .observe(on: UIScheduler())
            .startWithResult{ [weak self] (result) in
                switch result {
                case .success(let movies):
                    self?.movies.value = movies
                    self?.isPaginating = false
                case .failure(let error):
                    print(error)
                    if let error = error as? MovieServiceError {
                        switch error {
                        case .unvalidURL:
                            print(error.localizedDescription)
                        case .statusCodeError:
                            print(error.localizedDescription)
                        case .dataError:
                            print(error.localizedDescription)
                        case .decodingError:
                            print(error.localizedDescription)
                        case .urlSessionError(let currentError):
                            print(currentError)
                        }
                    }
                }
            }
    }
    
    func fetchMoreMovies(type: MovieType) {
        service?.currentMoviePage += 1
        disposes += service?.fetchMovies(type)
            .observe(on: UIScheduler())
            .startWithResult{ [weak self] (result) in
                switch result {
                case .success(let movies):
                    self?.movies.value.append(contentsOf: movies)
                    self?.isPaginating = false
                    print("Get API page \(self?.service?.currentMoviePage ?? 0) for \(type.description)")
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func clearObservation() {
        disposes.dispose()
    }
}

struct MovieVM {
    private(set) var movie: Movie
    
    var title: String {
        return movie.title
    }
    
    var rating: String {
        return "Rating: \(movie.rating)"
    }
    
    var coverImageURL: String {
        return movie.coverImageURL
    }
}







