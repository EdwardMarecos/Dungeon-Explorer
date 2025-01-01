//
//  DungeonView.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/26/24.
//

import SwiftUI

struct DungeonView: View {
    // store the returned tuple: (DungeonGrid, exit)
    @State private var dungeonGridAndExit = generateDungeonGrid()
    
    private var dungeon: DungeonGrid { dungeonGridAndExit.dungeon }
    private var previousExit: (Int, Int)? = nil  // store actual exit from the previous grid

    @State private var dungeonLevel = 1
    @State private var dungeonProgress = 0.0
    @State private var dungeonCompleted = false
    
    var body: some View {
        VStack {
            Text("Dungeon Explorer")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 20)

            Text("Dungeon Level: \(dungeonLevel)")
                .font(.headline)
                .padding(.bottom, 10)

            // Progress Bar
            ProgressView(value: dungeonProgress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()

            if !dungeonCompleted {
                // Display the dungeon grid
                DungeonGridView(dungeon: dungeon)

                Button {
                    advanceToNextDungeon()
                } label: {
                    Text("Enter New Dungeon")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            } else {
                // Completion
                Text("You've conquered the dungeon!")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()

                Button {
                    resetDungeon()
                } label: {
                    Text("Restart Dungeon")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
        .padding()
    }

    // MARK: - Advance Dungeon
    private func advanceToNextDungeon() {
        if dungeonLevel < 5 {
            // Grab the exit from the current dungeon
            let currentExit = dungeonGridAndExit.exit
            
            // Generate a new dungeon passing that exit
            dungeonGridAndExit = generateDungeonGrid(previousExit: currentExit)
            
            // Increase level and update progress
            dungeonLevel += 1
            // If 5 is max, we want the progress bar to be 1.0 at level 5:
            // that means at level=5, progress= (5-1)/(5-1)= 1.0
            dungeonProgress = Double(dungeonLevel - 1) / Double(5 - 1)
            
        } else {
            dungeonCompleted = true
        }
    }

    // MARK: - Reset
    private func resetDungeon() {
        dungeonGridAndExit = generateDungeonGrid()
        dungeonLevel = 1
        dungeonProgress = 0.0
        dungeonCompleted = false
    }
}
