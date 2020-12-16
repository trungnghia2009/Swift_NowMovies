//
//  MovieAPI.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation
import ReactiveSwift

private let nowPlayingQuery = QueryLink.shared.nowPlaying
private let popularQuery = QueryLink.shared.popular
private let topRatedQuery = QueryLink.shared.topRated
private let upcomingQuery = QueryLink.shared.upcoming
private let searchQuery = QueryLink.shared.search
private var coverImageHeaderQuery = QueryLink.shared.coverImageHeader
private var detailImageHeaderQuery = QueryLink.shared.detailImageHeader

// MARK: For Movies
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

enum MoviePropertyType {
    case detail
    case cast
    case image
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
    func fetchMovieDetail(id: Int) -> SignalProducer<MovieDetail, Error>
    var currentMoviePage: Int { get set }
}

class MovieService: MovieServiceProtocol {
    
    private var resourceURL: URL?
    var currentMoviePage = 1
    
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
                        var coverImageURL: String?
                        
                        if let posterPath = movieResult.posterPath {
                            coverImageURL = coverImageHeaderQuery + posterPath
                        }
                        
                        
                        let movie = Movie(id: movieResult.id,
                                          title: movieResult.title,
                                          rating: movieResult.voteAverage,
                                          coverImageURL: coverImageURL ?? "")
                        movies.append(movie)
                    }
                    
                    observer.send(value: movies)
                    observer.sendCompleted()
                } catch {
                    observer.send(error: MovieServiceError.decodingError)
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
            resourceURL = URL(string: nowPlayingQuery + "\(currentMoviePage)")
        case .popular:
            resourceURL = URL(string: popularQuery + "\(currentMoviePage)")
        case .topRated:
            resourceURL = URL(string: topRatedQuery + "\(currentMoviePage)")
        case .upcoming:
            resourceURL = URL(string: upcomingQuery + "\(currentMoviePage)")
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
    
    // MARK: Fetch movie detail
    func fetchMovieDetail(id: Int) -> SignalProducer<MovieDetail, Error> {
        print("\(QueryLink.shared.movieDetail(id: id))")
        
        return SignalProducer { observer, _ in
            guard let resourceURL = URL(string: QueryLink.shared.movieDetail(id: id)) else {
                print("unvalid URL for movie detail")
                observer.send(error: MovieServiceError.unvalidURL)
                observer.sendCompleted()
                return
            }
            
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
                
                // Handle data
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    do {
                        let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                        observer.send(value: movieDetail)
                        observer.sendCompleted()
                    } catch {
                        observer.send(error: MovieServiceError.decodingError)
                        observer.sendCompleted()
                    }
                    
                } else {
                    observer.send(error: MovieServiceError.dataError)
                    observer.sendCompleted()
                }
                
            }.resume()
            
        }
        
    }
    
    // MARK: Fetch Movie Cast
    func fetchMovieProperty(id: Int, type: MoviePropertyType) {
        
    }
    
}
