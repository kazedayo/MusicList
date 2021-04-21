//
//  AlbumListViewModelType.swift
//  MusicList
//
//  Created by Kin Wa Lam on 21/4/2021.
//

import Foundation
import RxSwift

protocol AlbumListViewModelType {
    var input: AlbumListViewModelInputs { get }
    var output: AlbumListViewModelOutputs { get }
}

protocol AlbumListViewModelInputs {
    func fetchAlbumList()
    func addFavorite(id: Int)
}

protocol AlbumListViewModelOutputs {
    var listLength: Observable<Int> { get }
    var albums: Observable<[Album]> { get }
}
