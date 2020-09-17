//
//  MovieAPI.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation
import ReactiveSwift

private let nowPlayingQuery = "https://api.themoviedb.org/3/movie/now_playing?api_key=989854c6c0be60cc4b2c40eb24cddeda"
private let popularQuery = "https://api.themoviedb.org/3/movie/popular?api_key=989854c6c0be60cc4b2c40eb24cddeda"
private let topRatedQuery = "https://api.themoviedb.org/3/movie/top_rated?api_key=989854c6c0be60cc4b2c40eb24cddeda"
private let upcomingQuery = "https://api.themoviedb.org/3/movie/upcoming?api_key=989854c6c0be60cc4b2c40eb24cddeda"
private let searchQuery = "https://api.themoviedb.org/3/search/movie?api_key=989854c6c0be60cc4b2c40eb24cddeda&query="

struct Movies: Decodable {
    var results: [MovieResult]
}

struct MovieResult: Decodable {
    var id: Int
    var title: String
    var voteAverage: Double
    var posterPath: String?
    var backdropPath: String?
    var overview: String
}

enum MovieServiceError: Error {
    case unvalidURL
    case statusCodeError
    case dataError
    case decodingError
}

protocol MovieServiceProtocol {
    func fetchMovies(_ type: MovieType) -> SignalProducer<[Movie], Error>
    func searchMovies(_ searchKey: String) -> SignalProducer<[Movie], Error>
    func fetchMoviesForSearching(_ searchKey: String) -> Signal<[Movie], Error>
}

class MovieService: MovieServiceProtocol {
    
    private var resourceURL: URL?
    
    fileprivate func handleURLSession(_ resourceURL: URL, _ observer: Signal<[Movie], Error>.Observer) {
        URLSession.shared.dataTask(with: resourceURL) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                observer.send(error: error)
                observer.sendCompleted()
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response")
                    observer.send(error: MovieServiceError.statusCodeError)
                    observer.sendCompleted()
                    return
            }
            
            if let data = data {
                var movies = [Movie]()
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let jsonData = try decoder.decode(Movies.self, from: data)
                    
                    jsonData.results.forEach { (movieResult) in
                        var coverImageURL = "https://image.tmdb.org/t/p/w200"
                        var detailImageURL = "https://image.tmdb.org/t/p/w500"
                        
                        if let posterPath = movieResult.posterPath {
                            coverImageURL += posterPath
                        }
                        
                        if let backdropPath = movieResult.backdropPath {
                            detailImageURL += backdropPath
                        }
                        
                        let movie = Movie(id: movieResult.id,
                                          title: movieResult.title,
                                          rating: movieResult.voteAverage,
                                          overview: movieResult.overview,
                                          coverImageURL: coverImageURL,
                                          detailImageURL: detailImageURL)
                        movies.append(movie)
                    }
                    
                    observer.send(value: movies)
                    observer.sendCompleted()
                } catch let error{
                    observer.send(error: error)
                    observer.sendCompleted()
                }
                
            } else {
                observer.send(error: MovieServiceError.dataError)
                observer.sendCompleted()
            }
            
        }.resume()
    }
    
    // MARK: - Fetch Movies
    func fetchMovies(_ type: MovieType) -> SignalProducer<[Movie], Error> {
        
        switch type {
        case .nowPlaying:
            resourceURL = URL(string: nowPlayingQuery)
        case .popular:
            resourceURL = URL(string: popularQuery)
        case .topRated:
            resourceURL = URL(string: topRatedQuery)
        case .upcoming:
            resourceURL = URL(string: upcomingQuery)
        }
        
        return SignalProducer { [weak self] observer, _ in
            guard let resourceURL = self?.resourceURL else {
                print("URL for \(type.description) got error")
                observer.send(error: MovieServiceError.unvalidURL)
                observer.sendCompleted()
                return
            }
            
            self?.handleURLSession(resourceURL, observer)
        }
    }
    
    // MARK: - Search Movies
    func searchMovies(_ searchKey: String) -> SignalProducer<[Movie], Error> {
        return SignalProducer { [weak self] observer, _ in
            print("Searching: " + searchKey)
            let transformSearchKey = searchKey.replacingOccurrences(of: " ", with: "%20")
            
            guard let resourceURL = URL(string: searchQuery + transformSearchKey) else {
                print("unvalid URL")
                observer.send(error: MovieServiceError.unvalidURL)
                observer.sendCompleted()
                return
            }
            
            self?.handleURLSession(resourceURL, observer)
        }

        
    }
    
    func fetchMoviesForSearching(_ searchKey: String) -> Signal<[Movie], Error> {
        
        return Signal { [weak self] observer, _ in
            
            guard let resourceURL = URL(string: searchQuery + searchKey) else {
                print("unvalid URL")
                observer.send(error: MovieServiceError.unvalidURL)
                observer.sendCompleted()
                return
            }
            
            print("\(searchQuery)" + searchKey)
            
            self?.handleURLSession(resourceURL, observer)
        }
        
        
    }
    
}
