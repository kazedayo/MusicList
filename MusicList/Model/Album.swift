//
//  Album.swift
//  MusicList
//
//  Created by Kin Wa Lam on 21/4/2021.
//

import Foundation

struct Album: Decodable {
    let collectionId: Int
    let collectionName: String
    let artistName: String
    let artworkUrl100: String
}
