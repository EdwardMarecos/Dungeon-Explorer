//
//  DungeonGenerator.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/26/24.
//

import Foundation

func generateDungeon() -> Dungeon {
    let rooms = [
        Room(id: 1, type: .empty),
        Room(id: 2, type: .enemy),
        Room(id: 3, type: .treasure),
        Room(id: 4, type: .enemy),
        Room(id: 5, type: .empty)
    ]
    return Dungeon(rooms: rooms, totalRooms: rooms.count)
}
