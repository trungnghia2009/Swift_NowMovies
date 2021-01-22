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

class MockApiService: MovieServiceProtocol {
    
    func fetchMovies(_ type: MovieType) -> SignalProducer<[Movie], Error> {
        return SignalProducer { observer, _ in
            var movies = [Movie]()
            
            switch type {
            
            case .nowPlaying:
                // 2 movies
                movies.append(Movie(id: 1234, title: "Test1", rating: 2, coverImageURL: "image1"))
                movies.append(Movie(id: 2345, title: "Test2", rating: 3, coverImageURL: "image2"))
            case .popular:
                // 3 movies
                movies.append(Movie(id: 1234, title: "Test1", rating: 2, coverImageURL: "image1"))
                movies.append(Movie(id: 2345, title: "Test2", rating: 3, coverImageURL: "image2"))
                movies.append(Movie(id: 2234, title: "Test3", rating: 3, coverImageURL: "image3"))
            case .topRated:
                // 4 movies
                movies.append(Movie(id: 1234, title: "Test1", rating: 2, coverImageURL: "image1"))
                movies.append(Movie(id: 2345, title: "Test2", rating: 3, coverImageURL: "image2"))
                movies.append(Movie(id: 2224, title: "Test3", rating: 2, coverImageURL: "image3"))
                movies.append(Movie(id: 3333, title: "Test4", rating: 3, coverImageURL: "image4"))
            case .upcoming:
                // 5 movies
                movies.append(Movie(id: 1234, title: "Test1", rating: 2, coverImageURL: "image1"))
                movies.append(Movie(id: 2345, title: "Test2", rating: 3, coverImageURL: "image2"))
                movies.append(Movie(id: 2224, title: "Test3", rating: 9, coverImageURL: "image3"))
                movies.append(Movie(id: 2223, title: "Test4", rating: 3, coverImageURL: "image4"))
                movies.append(Movie(id: 1234, title: "Test5", rating: 7, coverImageURL: "image5"))
            }
            observer.send(value: movies)
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
