//
//  LoginView.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/23/24.
//

import SwiftUI

struct LoginView: View {
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            ContentView() // Replace this with your home screen
        } else {
            VStack {
                Text("Dungeon Explorer")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 40)

                Button(action: {
                    isLoggedIn = true
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
}
