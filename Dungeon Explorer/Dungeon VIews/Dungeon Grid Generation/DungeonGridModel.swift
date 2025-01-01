//
//  DungeonGridModel.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/26/24.
//

/*
 
 _________________________________________________
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
 
 current plan is a 16 * 16 grid (prob gonna downsize after visualizing it here we shall see
 
 */


import Foundation

enum TileType {
    case wall      // Impassable wall
    case pathway   // Walkable pathway
    case enemy     // Enemy encounter
    case treasure  // Treasure spot
    case start     // Starting position
    case end       // Ending position
}

struct Tile {
    let x: Int
    let y: Int
    let type: TileType
}

struct DungeonGrid {
    var grid: [[Tile]]

    init(size: Int = 16) {
        grid = (0..<size).map { x in
            (0..<size).map { y in
                Tile(x: x, y: y, type: .wall) // Default all tiles to walls
            }
        }
    }

    mutating func setTileType(at x: Int, y: Int, to type: TileType) {
        grid[x][y] = Tile(x: x, y: y, type: type)
    }
}
