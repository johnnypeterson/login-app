//
//  LoginView.swift
//  Login App
//
//  Created by Johnny Peterson on 12/3/21.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    var onEditingChanged: ((Bool)->()) = {_ in }
    var color = Color("grayColor")
    @EnvironmentObject var viewModel: AuthenticationViewModel
   
    
    var body: some View {
        NavigationView {
        VStack {
            HStack {
            TextField("Username", text: $username)
                    .padding()
                Image(systemName: "lock")
                    .imageScale(.large)
                        .padding()
                        .foregroundColor(color)
            }
            .background(color.opacity(0.2)).clipShape(Capsule())
            HStack {
            SecureField("Password", text: self.$password,
                        onCommit: {
                //Could put field validation for password requirments here
                            self.onEditingChanged(false)
                        }
            ).padding()
                Image(systemName: "lock")
                    .imageScale(.large)
                        .padding()
                        .foregroundColor(color)
            }
            .background(color.opacity(0.2)).clipShape(Capsule())
            Button("Login", action: {viewModel.signIn(username: username, password: password)})
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                .padding(.all, 5.0)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: (self.password.isEmpty || self.username.isEmpty) ? [Color.gray, Color.gray] :  [Color.blue, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
                .disabled(self.password.isEmpty || self.username.isEmpty)

        } // Main VStack
        .padding(.all, 20)
        }// Navigation View
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
