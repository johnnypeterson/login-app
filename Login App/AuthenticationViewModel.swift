//
//  AuthenticationViewModel.swift
//  Login App
//
//  Created by Johnny Peterson on 12/3/21.
//

import SwiftUI
import Combine
import LocalAuthentication

/// A class conforming to `ObservableObject` used to represent a user's authentication status.
final class AuthenticationViewModel: ObservableObject {
    /// The user's log in status.
    /// - note: This will publish updates when its value changes.
    @Published var state: State
    @Published var isUnlocked = false
    // In a live app I would store this in coreData or some other persitence data storage like Realm.
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
        //TODO: Add logic for loading spinner while call is made to prevent multiple button presses.
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
                //TODO: store credentials in KeyChain to use with pin access or FaceId
                self.state = .signedIn(result)
            }.store(in: &subscriptions)
    }

    /// Signs the user out.
    func signOut() {
        self.user = nil
        self.state = .signedOut
        
    }
    func authenticateFaceId() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "We need to authenticate you."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        
                    }
                }
            }
        } else {
            // no biometrics handle error
        }
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
    
    enum PinIDState {
        case usePin
        case useBioMetric
        case usePassword
        
    }
}
