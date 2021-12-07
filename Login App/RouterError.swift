//
//  RouterError.swift
//  Login App
//
//  Created by Johnny Peterson on 12/3/21.
//

import Foundation

public enum RouterError: Error {
    case invalidStatusCode(Int)
    case emptyData
    case sessionExpired
    case other(Error)
    
    static func map(_ error: Error) -> Self {
        return (error as? Self) ?? .other(error)
    }
    
    
    public var stringValue: String {
        switch self {
        case .emptyData:
            return "The data is invalid or empty!"
        case .invalidStatusCode(let code):
            return "The request resulted in a status code: \(code)."
        case .sessionExpired:
            return "Session Expired"
        case .other(let error):
            return "An unknown error occurred: \(error)"
        }

    }
}
