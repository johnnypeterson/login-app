//
//  Login_AppApp.swift
//  Login App
//
//  Created by Johnny Peterson on 12/2/21.
//

import SwiftUI

@main
struct Login_AppApp: App {
    @StateObject var authViewModel = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
