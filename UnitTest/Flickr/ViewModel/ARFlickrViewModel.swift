//
//  ARFlickrViewModel.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 06/06/22.
//

import Foundation

typealias FlickrCompletionClosure = ((ARFlickrPhotoModel?, Error?) -> Void)

class ARFlickrViewModel {
    var flickrModel: ARFlickrPhotoModel?
    func callFlickrPhotoAPI(completion: @escaping FlickrCompletionClosure) {
        let networkManager = NewtworkManager(httpMethod: .GET)
        guard let request = networkManager?.createRequest(ARConstant.FlickrPhotoAPI, service: nil, params: [:]) else {
            completion(nil, ARNetworkError.invalidUrl)
            return
        }
        networkManager?.executeRequest(request: request, completion: completion)
    }
}
