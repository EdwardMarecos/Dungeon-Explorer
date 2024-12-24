//
//  DungeonStartView.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/23/24.
//

import SwiftUI

struct DungeonStartView: View {
    @State private var dungeonProgress = 0.0

    var body: some View {
        VStack {
            Text("Dungeon Progress")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)

            ProgressView(value: dungeonProgress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()

            Button(action: {
                if dungeonProgress < 1.0 {
                    dungeonProgress += 0.2
                }
            }) {
                Text("Advance")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            if dungeonProgress == 1.0 {
                Text("Dungeon Completed!")
                    .padding(.top, 20)
                    .foregroundColor(.green)
            }
        }
        .padding()
    }
}

#Preview {
    DungeonStartView()
}
