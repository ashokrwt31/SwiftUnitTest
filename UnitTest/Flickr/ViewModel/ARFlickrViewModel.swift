//
//  ARFlickrViewModel.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 06/06/22.
//

import Foundation

class ARFlickrViewModel {
    private let requestManager = ARRequestManager()
    
    func callFlickrPhotoAPIAsyncAwait() async throws -> ARFlickrPhotoModel {
        let response: ARFlickrPhotoModel = try await requestManager.perform(ARFlickrRequest())
        return response
    }
}
