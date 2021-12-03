//
//  AuthenticationViewModel.swift
//  Login App
//
//  Created by Johnny Peterson on 12/3/21.
//

import SwiftUI
import Combine

/// A class conforming to `ObservableObject` used to represent a user's authentication status.
final class AuthenticationViewModel: ObservableObject {
    /// The user's log in status.
    /// - note: This will publish updates when its value changes.
    @Published var state: State
    var user: User?
    private var subscriptions = Set<AnyCancellable>()

    
    /// Creates an instance of this view model.
    init() {
        if let user = user {
            self.state = .signedIn(user)
        } else {
            self.state = .signedOut
        }
    }
    
    /// Signs the user in.
    func signIn(username: String, password: String) {
        LoginManager.login(username: username, password: password)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("<<<<<ERROR:" + "\(error)")
                    break
                }
            } receiveValue: { (result) in
                self.user = result
                print(result)
                self.state = .signedIn(result)
            }.store(in: &subscriptions)
    }

    /// Signs the user out.
    func signOut() {
        self.user = nil
        self.state = .signedOut
        
    }
    
}

extension AuthenticationViewModel {
    /// An enumeration representing logged in status.
    enum State {
        /// The user is logged in and is the associated value of this case.
        case signedIn(User)
        /// The user is logged out.
        case signedOut
    }
}
