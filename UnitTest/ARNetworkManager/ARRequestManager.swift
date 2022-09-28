//
//  ARRequestManager.swift
//  UnitTest
//
//  Created by Ashok Rawat on 27/09/22.
//

import Foundation

protocol ARRequestManagerProtocol {
    func perform<T: Decodable>(_ request: ARRequestProtocol) async throws -> T
}

enum RequestType: String {
    case GET
    case POST
}

class ARRequestManager {    
    let networkManagerProtocol: ARNetworkManagerProtocol
    
    init(networkManagerProtocol: ARNetworkManagerProtocol = ARNetworkManager()) {
        self.networkManagerProtocol = networkManagerProtocol
    }
}

extension ARRequestManager: ARRequestManagerProtocol {
    
    func perform<T: Decodable>(_ request: ARRequestProtocol) async throws -> T {
        do {
            let data = try await networkManagerProtocol.perform(request, authToken: "")
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw error
        }
    }
}
