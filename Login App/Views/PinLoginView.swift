//
//  PinLoginView.swift
//  Login App
//
//  Created by Johnny Peterson on 12/7/21.
//

import SwiftUI


struct PinLoginView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
 
    
    var body: some View {
        VStack {
            if authViewModel.isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authViewModel.authenticateFaceId)
    }

}

struct PinLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PinLoginView()
    }
}
