//
//  ARFlickrPhotoModel.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 06/06/22.
//

import Foundation
 
struct ARFlickrPhotoModel: Codable {
 
    let items: [ARFlickr]
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
}

struct ARFlickr: Codable {
    let title: String
    let link: String
    let media: [String: String]
    let dateTaken: String
    let description: String
    let published: String
    let author: String
    let authorId: String
    let tags: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorId = "author_id"
        case tags
    }
}
