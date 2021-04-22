//
//  AlbumListViewModel.swift
//  MusicList
//
//  Created by Kin Wa Lam on 21/4/2021.
//

import Foundation
import RxSwift
import RxRelay

class AlbumListViewModel: AlbumListViewModelType, AlbumListViewModelInputs, AlbumListViewModelOutputs {

    var input: AlbumListViewModelInputs { return self }
    var output: AlbumListViewModelOutputs { return self }

    private let albumsRelay = BehaviorRelay<[AlbumListItem]>(value: [])
    private let showFavoriteRelay = BehaviorRelay<Bool>(value: false)
    
    func fetchAlbumList() {
        API.request() { [weak self] response in
            self?.albumsRelay.accept(response.results.map {
                return AlbumListItem(album: $0, isFavorite: false)
            })
        }
    }
    
    func toggleFavourite(id: Int) {
        var albums = albumsRelay.value
        if let targetIndex = albums.firstIndex(where: {$0.album.collectionId == id}) {
            albums[targetIndex].isFavorite = !albums[targetIndex].isFavorite
            albumsRelay.accept(albums)
        }
    }
    
    func toggleShowFavourite() {
        showFavoriteRelay.accept(!showFavoriteRelay.value)
    }

    let albums: Observable<[AlbumListItem]>
    let isShowingFavorites: Observable<Bool>
    
    init() {
        albums = albumsRelay.asObservable()
        isShowingFavorites = showFavoriteRelay.asObservable()
    }
}
