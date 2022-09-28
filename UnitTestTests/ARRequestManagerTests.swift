//
//  ARRequestManagerTests.swift
//  UnitTestTests
//
//  Created by Ashok Rawat on 27/09/22.
//

import XCTest
@testable import UnitTest

class ARRequestManagerTests: XCTestCase {
    
    private var requestManager: ARRequestManagerProtocol?

    override func setUp() {
        super.setUp()
        requestManager = ARRequestManager(networkManagerProtocol: ARNetworkManagerMock())
    }
    
    func testFlickrPhotoRequest() async throws {
        guard let viewModel: ARFlickrPhotoModel =
                try await requestManager?.perform(ARFlickrRequestMock()) else {
          XCTFail("Didn't get data from the request manager")
          return
        }

      let photoItems = viewModel.items

      let first = photoItems.first
      let last = photoItems.last
      XCTAssertEqual(first?.title, "1_olive_wood_spoons")
        
      XCTAssertEqual(last?.title, "Potato Peelings")
    }
    
    override func tearDown() {
        requestManager = nil
    }
}
