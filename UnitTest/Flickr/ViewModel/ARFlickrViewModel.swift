//
//  ARFlickrViewModel.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 06/06/22.
//

import Foundation

typealias FlickrCompletionClosure = ((ARFlickrPhotoModel?, Error?) -> Void)

class ARFlickrViewModel {
    private let requestManager = ARRequestManager()
    func callFlickrPhotoAPI(completion: @escaping FlickrCompletionClosure) {
//        let networkManager = NewtworkManager(httpMethod: .GET)
//        guard let request = networkManager?.createRequest(ARConstant.FlickrPhotoAPI, service: nil, params: [:]) else {
//            completion(nil, ARNetworkError.invalidUrl)
//            return
//        }
//        networkManager?.executeRequest(request: request, completion: completion)
        
    }
    
    func callFlickrPhotoAPIAsyncAwait() async throws -> ARFlickrPhotoModel {
        let response: ARFlickrPhotoModel = try await requestManager.perform(ARFlickrRequest())
        return response
    }
}
