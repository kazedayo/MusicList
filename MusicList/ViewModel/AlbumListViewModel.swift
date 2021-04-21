//
//  AlbumListViewModel.swift
//  MusicList
//
//  Created by Kin Wa Lam on 21/4/2021.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire

class AlbumListViewModel: AlbumListViewModelType, AlbumListViewModelInputs, AlbumListViewModelOutputs {
    var input: AlbumListViewModelInputs { return self }
    var output: AlbumListViewModelOutputs { return self }
    
    private let listLengthRelay = PublishRelay<Int>()
    private let albumsRelay = PublishRelay<[Album]>()
    
    func fetchAlbumList() {
        AF.request(API.url).responseDecodable(of: ApiResponse.self) { [weak self] response in
            if let response = response.value {
                self?.listLengthRelay.accept(response.resultCount)
                self?.albumsRelay.accept(response.results)
            }
        }
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
