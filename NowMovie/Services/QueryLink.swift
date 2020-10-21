//
//  QueryLink.swift
//  NowMovie
//
//  Created by NghiaTran on 9/29/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation

struct QueryLink {
    static let shared = QueryLink()
    private init() {}
    
    let nowPlayingQuery = "https://api.themoviedb.org/3/movie/now_playing?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    let popularQuery = "https://api.themoviedb.org/3/movie/popular?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    let topRatedQuery = "https://api.themoviedb.org/3/movie/top_rated?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    let upcomingQuery = "https://api.themoviedb.org/3/movie/upcoming?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    let searchQuery = "https://api.themoviedb.org/3/search/movie?api_key=989854c6c0be60cc4b2c40eb24cddeda&query="
    
    func movieDetailQuery(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
    
    func movieCastQuery(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
    
    func movieVideoQuery(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
    
    func movieSimilarQuery(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
    
    func movieRecommendationsQuery(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
}
