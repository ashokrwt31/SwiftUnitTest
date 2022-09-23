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
//    let dateTaken: String
    let description: String
    let published: String
    let author: String
//    let authorIid: String
    let tags: String
    
//    private enum FlickrPhotoKeys: String, CodingKey {
//        case title
//        case link
//        case media
//        case dateTaken = "date_taken"
//        case description
//        case published
//        case author
//        case authorId = "author_id"
//        case tags
//    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: FlickrPhotoKeys.self)
//        self.title = try container.decode(String.self, forKey: title)
//        self.link = try container.decode(String.self, forKey: link)
//        self.media = try container.decode(Dictionary.self, forKey: media)
//        self.dateTaken = try container.decode(String.self, forKey: dateTaken)
//        self.description = try container.decode(String.self, forKey: description)
//        self.published = try container.decode(String.self, forKey: published)
//        self.author = try container.decode(String.self, forKey: author)
//        self.authorId = try container.decode(String.self, forKey: authorId)
//        self.tags = try container.decode(String.self, forKey: tags)
//    }
}
