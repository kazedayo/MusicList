//
//  ApiResponse.swift
//  MusicList
//
//  Created by Kin Wa Lam on 21/4/2021.
//

import Foundation

struct ApiResponse: Decodable {
    let resultCount: Int
    let results: [Album]
}
