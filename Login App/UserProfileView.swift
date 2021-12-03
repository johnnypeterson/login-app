//
//  UserProfileView.swift
//  Login App
//
//  Created by Johnny Peterson on 12/3/21.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
  
    var body: some View {
        VStack {
            HStack {
                Text("Name:")
                Text(authViewModel.user?.displayName ?? "Name")
            }
            .padding()
            HStack {
                //I Wouldn't show this to the user in a real app
                Text("Token:")
                Text(authViewModel.user?.token ?? "Token")
            }
            .padding()
            HStack {
                Text("User ID:")
                Text(authViewModel.user?.userID ?? "User ID")
            }
            .padding()
        }
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(NSLocalizedString("Sign Out", comment: "Sign out button"), action: signOut)
              .accessibilityLabel(Text("Sign out button"))
          }
        }

    }
    
    func signOut() {
      authViewModel.signOut()
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
