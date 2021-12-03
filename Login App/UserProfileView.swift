//
//  UserProfileView.swift
//  Login App
//
//  Created by Johnny Peterson on 12/3/21.
//

import SwiftUI

struct UserProfileView: View {
    public var user:User?
    var body: some View {
        VStack {
            HStack {
                Text("Name:")
                Text(user?.displayName ?? "Name")
            }
            .padding()
            HStack {
                //I Wouldn't show this to the user in a real app
                Text("Token:")
                Text(user?.token ?? "Token")
            }
            .padding()
            HStack {
                Text("User ID:")
                Text(user?.userID ?? "User ID")
            }
            .padding()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
