//
//  API.swift
//  MusicList
//
//  Created by Kin Wa Lam on 21/4/2021.
//

import Foundation
import Alamofire

final class API {
    static let url: String = "https://itunes.apple.com/search?term=jack+johnson&entity=album"
    
    func request() -> ApiResponse? {
        var apiResponse: ApiResponse?
        AF.request(API.url).responseDecodable(of: ApiResponse.self) {
            response in
            apiResponse = response.value
        }
        return apiResponse
    }
}
