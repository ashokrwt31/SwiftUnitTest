//
//  ARNetworkManagerMock.swift
//  UnitTestTests
//
//  Created by Ashok Rawat on 27/09/22.
//

import XCTest
@testable import UnitTest

struct ARNetworkManagerMock: ARNetworkManagerProtocol {
    
    func perform(_ request: UnitTest.ARRequestProtocol, authToken: String) async throws -> Data {
        return try Data(contentsOf: URL(fileURLWithPath: request.path), options: .mappedIfSafe)
    }
}
