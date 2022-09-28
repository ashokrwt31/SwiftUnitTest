//
//  ARFlickrRequest.swift
//  UnitTest
//
//  Created by Ashok Rawat on 27/09/22.
//

import Foundation

class ARFlickrRequest: ARRequestProtocol {
    var path: String {
        "/v1/9ef37951-7603-463d-8aa7-c0c5a682793"
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var addAuthToken: Bool {
        false
    }
}
