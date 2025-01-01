//
//  DungeonModel.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/26/24.
//

import Foundation

// Represents a single room in the dungeon
struct Room {
    let id: Int             // Unique identifier for the room
    let type: RoomType      // Type of the room (enemy, treasure, etc.)
}

// Defines the possible types of rooms in the dungeon
enum RoomType {
    case empty              // No encounter
    case enemy              // Enemy encounter
    case treasure           // Treasure room
}

// Represents the entire dungeon
struct Dungeon {
    let rooms: [Room]       // List of rooms in the dungeon
    let totalRooms: Int     // total number of rooms in the dungeon (for progress indication)
}
