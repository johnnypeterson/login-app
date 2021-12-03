//
//  Routable.swift
//  Login App
//
//  Created by Johnny Peterson on 12/3/21.
//

import Foundation
import Alamofire
import Combine

protocol Routable: URLRequestConvertible {
    static var baseURL: URL { get }
    
    static var token: String { get }
    
    var path: String { get }
    
    var parameters: Parameters { get }
    
    var httpMethod: HTTPMethod { get }
}

extension Routable {
    
    public func request<T: Decodable>(type: T.Type, token: String = "") -> AnyPublisher<T, RouterError> {
        return AF.request(self).publishData()
            .tryMap { response in
                if let httpResponse = response.response, !(httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
                    if (httpResponse.statusCode >= 400 && httpResponse.statusCode < 500) {
                    throw RouterError.sessionExpired
                    } else {
                        throw RouterError.invalidStatusCode(httpResponse.statusCode)
                    }
                
                }
                
                guard let data = response.data else {
                    throw RouterError.emptyData
                }
                
                return data
            }
            .decode(type: type, decoder: JSONDecoder())
            .mapError { RouterError.map($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
