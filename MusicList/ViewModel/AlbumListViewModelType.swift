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
    func toggleFavourite(id: Int)
    func toggleShowFavourite()
}

protocol AlbumListViewModelOutputs {
    var isShowingFavorites: Observable<Bool> { get }
    var albums: Observable<[AlbumListItem]> { get }
}
