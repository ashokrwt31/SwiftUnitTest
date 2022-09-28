//
//  ARFlickrRequestTests.swift
//  UnitTestTests
//
//  Created by Ashok Rawat on 27/09/22.
//

import XCTest
@testable import UnitTest

struct ARFlickrRequestMock: ARRequestProtocol {
    
    var path: String {
        guard let path = Bundle.main.path(forResource: "jsonviewer", ofType: "json") else { return "" }
        return path
    }
    
    var requestType: UnitTest.RequestType {
        .GET
    }
}
