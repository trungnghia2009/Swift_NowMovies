//
//  MockApiService.swift
//  NowMovieUnitTests
//
//  Created by NghiaTran on 22/01/2021.
//  Copyright © 2021 trungnghia. All rights reserved.
//

import Foundation
import ReactiveSwift

@testable import NowMovie

class MockApiServiceFailed: MovieServiceProtocol {
    
    func fetchMovies(_ type: MovieType) -> SignalProducer<[Movie], Error> {
        return SignalProducer { observer, _ in
            observer.send(error: MovieServiceError.unvalidURL)
            observer.sendCompleted()
        }
    }
    
    func searchMovies(_ searchKey: String) -> SignalProducer<[Movie], Error> {
        return SignalProducer { observer, _ in
            observer.send(value: [Movie]())
            observer.sendCompleted()
        }
    }
    
    func fetchMovieDetail(id: Int) -> SignalProducer<MovieDetail, Error> {
        return SignalProducer { observer, _ in
            let movieDetail = MovieDetail(id: 22, title: "sdd", overview: "12", releaseDate: "", status: "howt", voteAverage: 4.4, voteCount: 2, adult: true, backdropPath: "d", genres: [Genres(id: 2, name: "Hot")])
            observer.send(value: movieDetail)
            observer.sendCompleted()
        }
    }
    
    var currentMoviePage: Int = 1
    
    
}
