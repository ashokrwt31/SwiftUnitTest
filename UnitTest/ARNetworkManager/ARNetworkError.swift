//
//  ARNetworkError.swift
//  UnitTest
//
//  Created by Ashok Rawat on 27/09/22.
//

import Foundation

enum ARNetworkError: Error {
    case invalidUrl
    case invalidData
    case invalidServerResponse
    
    public var errorDescription: String? {
      switch self {
      case .invalidServerResponse:
        return "The server returned an invalid response."
      case .invalidUrl:
        return "URL string is malformed."
      case .invalidData:
        return "Invalid data, data is not as per model."
      }
    }
}
