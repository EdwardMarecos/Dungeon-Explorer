//
//  DungeonView.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/26/24.
//


import SwiftUI

struct DungeonView: View {
    @State private var currentRoomIndex = 0 // Tracks the player's current position in the dungeon
    @State private var dungeon = generateDungeon() // Holds the generated dungeon
    @State private var dungeonProgress = 0.0 // Tracks progress as a fraction
    @State private var dungeonCompleted = false // Tracks if the dungeon is completed

    var body: some View {
        VStack {
            Text("Dungeon Explorer")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 40)

            // Progress Bar
            ProgressView(value: dungeonProgress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()

            if currentRoomIndex < dungeon.totalRooms - 1 {  // the -1 is to fix an error caused by testing array index rather then length :3
                // Current Room Info
                let currentRoom = dungeon.rooms[currentRoomIndex]

                Text("Room \(currentRoom.id)")
                    .font(.headline)
                    .padding()

                switch currentRoom.type {
                case .empty:
                    Text("This room is empty.")
                case .enemy:
                    Text("An enemy is here!")
                case .treasure:
                    Text("You found treasure!")
                }
                
                Button(action: {
                    advanceRoom()
                }) {
                    Text("Move Forward")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            } else if dungeonProgress >= 1.0 {
                // Dungeon Completion
                Text("Dungeon Completed!")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()

                Button(action: {
                    resetDungeon()
                }) {
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

    // Advances to the next room and updates progress
        private func advanceRoom() {
            print("Before advancing: currentRoomIndex=\(currentRoomIndex), dungeonProgress=\(dungeonProgress)")

            if currentRoomIndex < dungeon.totalRooms - 1 {
                currentRoomIndex += 1
                dungeonProgress = Double(currentRoomIndex + 1) / Double(dungeon.totalRooms)
            } else {
                // Mark dungeon as completed
                dungeonProgress = 1.0
                dungeonCompleted = true // Trigger UI change
                print("Dungeon Completed! dungeonProgress=\(dungeonProgress)")
            }

            print("After advancing: currentRoomIndex=\(currentRoomIndex), dungeonProgress=\(dungeonProgress)")
        }

    // Resets the dungeon for replayability
    private func resetDungeon() {
        dungeon = generateDungeon()
        currentRoomIndex = 0
        dungeonProgress = 0.0
        print("Dungeon Reset! currentRoomIndex=\(currentRoomIndex), dungeonProgress=\(dungeonProgress)")
    }
}
