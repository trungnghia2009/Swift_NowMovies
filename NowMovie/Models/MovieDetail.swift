//
//  MovieDetail.swift
//  NowMovie
//
//  Created by NghiaTran on 10/20/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let status: String
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    let backdropPath: String
    let genres: [Genres]
    
}

struct Genres: Decodable {
    let id: Int
    let name: String
}
