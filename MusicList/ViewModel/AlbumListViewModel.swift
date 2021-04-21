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
    
    func fetchAlbumList() {
        guard let response = API.request() else { return }
        listLengthRelay.accept(response.resultCount)
        albumsRelay.accept(response.result)
    }
    
    func addFavorite(id: Int) {
        
    }
    
    let listLength: Observable<Int>
    let albums: Observable<[Album]>
    
    init() {
        listLength = listLengthRelay.asObservable()
        albums = albumsRelay.asObservable()
    }
}
