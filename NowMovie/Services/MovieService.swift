//
//  MovieAPI.swift
//  NowMovie
//
//  Created by trungnghia on 9/13/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation

private let nowPlayingQuery = "https://api.themoviedb.org/3/movie/now_playing?api_key=989854c6c0be60cc4b2c40eb24cddeda&language=en-US&page=1"
private let popularQuery = "https://api.themoviedb.org/3/movie/popular?api_key=989854c6c0be60cc4b2c40eb24cddeda&language=en-US&page=1"
private let topRatedQuery = "https://api.themoviedb.org/3/movie/top_rated?api_key=989854c6c0be60cc4b2c40eb24cddeda&language=en-US&page=1"
private let upcomingQuery = "https://api.themoviedb.org/3/movie/upcoming?api_key=989854c6c0be60cc4b2c40eb24cddeda&language=en-US&page=1"

struct Movies: Decodable {
    var results: [MovieResult]
}

struct MovieResult: Decodable {
    var id: Int
    var title: String
    var voteAverage: Double
    var posterPath: String
    var backdropPath: String
    var overview: String
}

enum MovieServiceError: Error {
    case unknownError
    case statusCodeError
    case dataError
    case decodingError
}

protocol MovieServiceProtocol {
    func fetchMovies(_ type: MovieType, completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    private var resourceURL: URL?
    
    func fetchMovies(_ type: MovieType, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
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
        
        guard let resourceURL = resourceURL else {
            print("URL for \(type.description) got error")
            completion(.failure(MovieServiceError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: resourceURL) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response")
                    completion(.failure(MovieServiceError.statusCodeError))
                    return
            }
            
            if let data = data {
                var movies = [Movie]()
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let jsonData = try decoder.decode(Movies.self, from: data)
                    
                    jsonData.results.forEach { (movieResult) in
                        let coverImageURL = "https://image.tmdb.org/t/p/w200" + movieResult.posterPath
                        let detailImageURL = "https://image.tmdb.org/t/p/w500" + movieResult.backdropPath
                        
                        let movie = Movie(id: movieResult.id,
                                               title: movieResult.title,
                                               rating: movieResult.voteAverage,
                                               overview: movieResult.overview,
                                               coverImageURL: coverImageURL,
                                               detailImageURL: detailImageURL)
                        movies.append(movie)
                    }
                    completion(.success(movies))
                } catch {
                    completion(.failure(MovieServiceError.decodingError))
                }
                
            } else {
                completion(.failure(MovieServiceError.dataError))
            }
            
        }.resume()
    }
}
