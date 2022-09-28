//
//  ARNetworkManager.swift
//  UnitTest
//
//  Created by Ashok Rawat on 27/09/22.
//

import Foundation

protocol ARNetworkManagerProtocol {
  func perform(_ request: ARRequestProtocol, authToken: String) async throws -> Data
}

class ARNetworkManager {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
}

extension ARNetworkManager: ARNetworkManagerProtocol {
    
    func perform(_ request: ARRequestProtocol, authToken: String = "") async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createURLRequest(authToken: authToken))
        
        guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
            throw ARNetworkError.invalidServerResponse
        }
        return data
    }
}
