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
    
    let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=989854c6c0be60cc4b2c40eb24cddeda&page="
    let popular = "https://api.themoviedb.org/3/movie/popular?api_key=989854c6c0be60cc4b2c40eb24cddeda&page="
    let topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=989854c6c0be60cc4b2c40eb24cddeda&page="
    let upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=989854c6c0be60cc4b2c40eb24cddeda&page="
    let search = "https://api.themoviedb.org/3/search/movie?api_key=989854c6c0be60cc4b2c40eb24cddeda&query="
    let coverImageHeader = "https://image.tmdb.org/t/p/w200"
    let detailImageHeader = "https://image.tmdb.org/t/p/original"
    
    func movieDetail(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
    
    func movieCast(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
    
    func movieVideo(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
    
    func movieSimilar(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
    
    func movieRecommendations(id: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=989854c6c0be60cc4b2c40eb24cddeda"
    }
}
