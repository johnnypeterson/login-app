//
//  ContentView.swift
//  Login App
//
//  Created by Johnny Peterson on 12/2/21.
//

import SwiftUI
import Combine

struct ContentView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel

  var body: some View {
    return Group {
      NavigationView {
        switch authViewModel.state {
        case .signedIn:
            UserProfileView(user: authViewModel.user)
            .navigationTitle(
              NSLocalizedString(
                "User Profile",
                comment: "User profile navigation title"
              ))
        case .signedOut:
          LoginView()
            .navigationTitle(
              NSLocalizedString(
                "Login",
                comment: "Sign-in navigation title"
              ))
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}
