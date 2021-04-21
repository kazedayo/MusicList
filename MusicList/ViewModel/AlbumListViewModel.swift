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
    
    private let listLengthRelay = PublishRelay<Int>()
    private let albumsRelay = PublishRelay<[Album]>()
    private let showFavoriteRelay = BehaviorRelay<Bool>(value: false)
    private var favouriteAlbumIds: [Int] = []
    private var albumList: [Album] = []
    
    func fetchAlbumList() {
        API.request() { [weak self] response in
            self?.listLengthRelay.accept(response.resultCount)
            self?.albumsRelay.accept(response.results)
            //make a copy for filtering purpose
            self?.albumList = response.results
        }
    }
    
    func addFavorite(id: Int) {
        favouriteAlbumIds.append(id)
    }
    
    func toggleFavourite() {
        showFavoriteRelay.accept(!showFavoriteRelay.value)
        albumsRelay.accept(showFavoriteRelay.value ? albumList.filter({favouriteAlbumIds.contains($0.collectionId)}) : albumList)
    }
    
    let listLength: Observable<Int>
    let albums: Observable<[Album]>
    let isShowingFavorites: Observable<Bool>
    
    init() {
        listLength = listLengthRelay.asObservable()
        albums = albumsRelay.asObservable()
        isShowingFavorites = showFavoriteRelay.asObservable()
    }
}
