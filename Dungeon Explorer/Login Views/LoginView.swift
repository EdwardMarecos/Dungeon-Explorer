//
//  LoginView.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/23/24.
//

import SwiftUI

struct LoginView: View {
    var onLogin: () -> Void

    var body: some View {
        VStack {
            Text("Dungeon Explorer")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)

            Button(action: {
                onLogin() // Call the login closure
            }) {
                Text("Log In")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}
