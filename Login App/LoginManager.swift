//
//  LoginManager.swift
//  Login App
//
//  Created by Johnny Peterson on 12/3/21.
//

import Foundation
import Combine
import Alamofire

public struct LoginManager {
    public static func login(username: String, password: String) -> AnyPublisher<User, RouterError> {
        let router: LoginRouter = .login(username: username, password: password)
        return router.request(type: User.self)
            .eraseToAnyPublisher()
    }

}
