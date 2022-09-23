//
//  ARFlickrPhoto.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 11/05/22.
//

import Foundation

struct ARFlickrPhoto: Equatable {
    
    let photoID: String
    let farm: String
    let server: String
    let secret: String
    
    init(photoID: String, farm: String, server: String, secret: String ) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
    }
    
    func imageUrl( size: String = "m") -> URL? {
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg") {
              return url
            }
            return nil
    }
}

extension ARFlickrPhoto: Codable {
    
}
