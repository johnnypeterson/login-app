//
//  LoginRouter.swift
//  Login App
//
//  Created by Johnny Peterson on 12/2/21.
//

import Foundation
import Alamofire
//Created using Alamofire but since this is modular it is easy to switch out for something else.

public enum LoginRouter: Routable {
    case login(username: String, password: String)
  
    
    static var baseURL: URL {return URL(string: "https://ad2ed412-f5ca-4026-88df-11f62d2ceb58.mock.pstmn.io/")!}
    
    static var token: String { return "" }
    
    var path: String {
        
        switch self {
        case .login:
            return "login"
       
        }
    }
    
    var parameters: Parameters {
        var params = Parameters()
        switch self {
        
        case .login(username: let username, password: let password):
           
    
            params["username"] = username
            params["password"] = password
           
        }
        return params
    }
    
    var httpMethod: HTTPMethod {
    switch self {
    case .login:
        return .post
    }
    
    
    }
    
    public func asURLRequest() throws -> URLRequest {
        var urlRequest: URLRequest
        
        urlRequest = URLRequest(url: LoginRouter.baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = httpMethod.rawValue
        
        if httpMethod == .get {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            urlRequest.headers = HTTPHeaders([HTTPHeader(name: "Content-Type", value: "application/json")])
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
    
    
}
