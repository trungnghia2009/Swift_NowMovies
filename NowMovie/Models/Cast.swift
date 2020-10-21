//
//  Cast.swift
//  NowMovie
//
//  Created by NghiaTran on 10/21/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import Foundation

struct Cast: Decodable {
    let castId: Int
    let character: String
    let creditId: String
    let gender: Int
    let id: Int
    let name: String
    let order: Int
    var profilePath: String?
}
