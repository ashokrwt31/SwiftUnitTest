//
//  NetworkManager.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 06/06/22.
//

import Foundation

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
    
    var method: String { return rawValue.uppercased() }
}

struct NewtworkManager {
    private let httpMethod: String
    
    public init?(httpMethod: HTTPMethod = .GET) {
        self.httpMethod = httpMethod.method
    }
     
    public func createRequest(_ url: String, service: String?, params: [String: Any]?) -> URLRequest? {
        
        var finalURL = URL(string: url)
        if let ser = service, let  _ = finalURL {
            finalURL = finalURL?.appendingPathComponent(ser)
        }
        guard let strURL = finalURL else {
            return nil
        }
        
        var request = URLRequest(url: strURL)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.networkServiceType = .default
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 100
        request.httpShouldHandleCookies = true
        request.httpShouldUsePipelining = false
        request.allowsCellularAccess = true
        return request
    }
    
    public func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)

        let dataTask = session.dataTask(with: request) { (data, _, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                    completion?(decodedResponse, nil)
            } else {
                completion?(nil, ARNetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
}
