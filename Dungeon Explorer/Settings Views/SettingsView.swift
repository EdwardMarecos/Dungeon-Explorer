//
//  SettingsView.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/23/24.
//

import SwiftUI

struct SettingsView: View {
    var onLogout: () -> Void

    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)

            Button(action: {
                onLogout() // Call the logout closure
            }) {
                Text("Log Out")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}

