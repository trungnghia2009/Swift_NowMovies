//
//  MovieTypesVM.swift
//  NowMovie
//
//  Created by trungnghia on 14/12/2020.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation

enum MovieType: CaseIterable, CustomStringConvertible {
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var description: String {
        switch self {
        case .nowPlaying: return "Now Playing Movies"
        case .popular: return "Popular Movies"
        case .topRated: return "Top Rated Movies"
        case .upcoming: return "Upcoming Movies"
        }
    }
}

class MovieTypeVM {
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return MovieType.allCases.count
    }
    
    func movieTypeAtIndex(_ index: Int) -> String {
        return MovieType.allCases[index].description
    }
    
    
}
