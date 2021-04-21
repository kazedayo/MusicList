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
    func toggleFavourite()
}

protocol AlbumListViewModelOutputs {
    var listLength: Observable<Int> { get }
    var isShowingFavorites: Observable<Bool> { get }
    var albums: Observable<[Album]> { get }
}
