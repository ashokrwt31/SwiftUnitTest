//
//  ARRequestProtocol.swift
//  UnitTest
//
//  Created by Ashok Rawat on 27/09/22.
//

import Foundation

protocol ARRequestProtocol {
    
    var path: String { get }
    
    var headers: [String: String] { get }
    
    var params: [String: Any] { get }
    
    var urlParams: [String: String?] { get }
    
    var addAuthToken: Bool { get }
    
    var requestType: RequestType { get }
}

extension ARRequestProtocol {
    var host: String {
        ARConstant.FlickrPhotoAPI
    }
    
    var addAuthToken: Bool {
        true
    }
    
    var params: [String: Any] {
        [:]
      }
    
    var urlParams: [String: String?] {
        [:]
      }

      var headers: [String: String] {
        [:]
      }
}

extension ARRequestProtocol {
    
    func createURLRequest(authToken: String) throws -> URLRequest {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        guard let url = components.url else {
            throw ARNetworkError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            request.allHTTPHeaderFields = headers
        }
        
        if addAuthToken {
            request.setValue(authToken, forHTTPHeaderField: "Authorization")
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !params.isEmpty {
            request.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return request
    }
}
