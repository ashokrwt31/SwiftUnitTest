//
//  ARFlickrViewModel.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 06/06/22.
//

import Foundation

typealias FlickrCompletionClosure = ((ARFlickrPhotoModel?, Error?) -> Void)

let flickrPhotoAPI = "https://mocki.io/v1/9ef37951-7603-463d-8aa7-c0c5a6827939"
//"https://json-generator.com/api/json/get/cginvNuCuW?indent=4#"

    // "https://codebeautify.org/jsonviewer/y22cb551d"

class ARFlickrViewModel {
    var flickrModel: ARFlickrPhotoModel?
    func callFlickrPhotoAPI(completion: @escaping FlickrCompletionClosure) {
        let networkManager = NewtworkManager(httpMethod: .GET)
        guard let urlString = flickrPhotoAPI.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else { return }
        guard let request = networkManager?.createRequest(urlString, service: nil, params: [:]) else {
            completion(nil, ARNetworkError.invalidUrl)
            return
        }
        networkManager?.executeRequest(request: request, completion: completion)
    }
}
