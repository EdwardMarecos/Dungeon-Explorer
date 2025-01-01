//
//  DungeonGridGenerator.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/26/24.
//

import Foundation

func generateDungeonGrid(size: Int = 16,
                         previousExit: (Int, Int)? = nil)
-> (dungeon: DungeonGrid, exit: (Int, Int))
{
    var dungeon = DungeonGrid(size: size)
    
    // 1) Always place entrance on the LEFT wall for the first dungeon.
    //    For subsequent dungeons, reflect from the previous exit.
    let entrance = previousExit == nil
        ? (0, Int.random(in: 1..<(size-1)))
        : oppositeWallCoordinate(exit: previousExit!, gridSize: size)
    
    // 2) Identify which wall the entrance occupies (so we can exclude it for exit).
    let usedWall = getWallOfCoordinate(entrance, gridSize: size)
    
    // 3) Decide how far the exit must be from the entrance:
    //    - For the first dungeon, require a "healthy" distance (e.g., 75% of grid size).
    //    - For later levels, 5.0 or whatever minimal distance you prefer.
    let minDistanceRequired: Double = (previousExit == nil)
        ? Double(size) * 0.75
        : 5.0
    
    // 4) Pick exit from the other three walls, enforcing minDistance.
    let exit = pickExitFromWalls(
        excludingWall: usedWall,
        gridSize: size,
        entrance: entrance,
        minDistance: minDistanceRequired
    )
    
    // 5) Fill edges with walls, skipping entrance & exit
    fillEdgesAsWalls(
        in: &dungeon,
        size: size,
        entrance: entrance,
        exit: exit
    )
    
    // 6) Mark entrance & exit
    dungeon.setTileType(at: entrance.0, y: entrance.1, to: .start)
    dungeon.setTileType(at: exit.0, y: exit.1, to: .end)
    
    // 7) Randomize interior, then carve a path from entrance to exit
    fillInteriorRandomly(in: &dungeon, size: size, skipping: [entrance, exit])
    createPath(from: entrance, to: exit, in: &dungeon)
    
    return (dungeon, exit)
}


// MARK: - Separate wall-making

private func fillEdgesAsWalls(in dungeon: inout DungeonGrid,
                              size: Int,
                              entrance: (Int, Int),
                              exit: (Int, Int)) {
    for x in 0..<size {
        for y in 0..<size {
            let isEdge = (x == 0 || x == size-1 || y == 0 || y == size-1)
            if isEdge {
                // Only place wall if not entrance or exit
                if (x, y) != entrance && (x, y) != exit {
                    dungeon.setTileType(at: x, y: y, to: .wall)
                }
            }
        }
    }
}

// MARK: - Separate interior randomization

private func fillInteriorRandomly(in dungeon: inout DungeonGrid,
                                  size: Int,
                                  skipping: [(Int, Int)]
) {
    for x in 1..<(size-1) {
        for y in 1..<(size-1) {
            // Skip if it's entrance/exit or already a wall
            if skipping.contains(where: { $0 == (x, y) }) { continue }
            if dungeon.grid[x][y].type == .wall { continue }
            
            let randomValue = Int.random(in: 0...100)
            switch randomValue {
            case 0..<65:
                dungeon.setTileType(at: x, y: y, to: .pathway)
            case 65..<75:
                dungeon.setTileType(at: x, y: y, to: .enemy)
            case 75..<80:
                dungeon.setTileType(at: x, y: y, to: .treasure)
            default:
                dungeon.setTileType(at: x, y: y, to: .wall)
            }
        }
    }
}

// MARK: - Path Carving

func createPath(
    from start: (Int, Int),
    to end: (Int, Int),
    in dungeon: inout DungeonGrid
) {
    let width = dungeon.grid.count
    let height = dungeon.grid[0].count
    
    var current = start

    // Pathfinding loop
    while current != end {
        // Mark current cell as part of the path
        dungeon.setTileType(at: current.0, y: current.1, to: .pathway)
        
        // Gather all potential moves that go “closer” in x/y
        // AND remain inside (or are the `end`) so we don't touch edges.
        var possibleMoves: [(Int, Int)] = []
        
        // Move right if current.x < end.x
        if current.0 < end.0 {
            let newPos = (current.0 + 1, current.1)
            if isInInteriorOrEnd(newPos, end: end, width: width, height: height) {
                possibleMoves.append(newPos)
            }
        }
        
        // Move left if current.x > end.x
        if current.0 > end.0 {
            let newPos = (current.0 - 1, current.1)
            if isInInteriorOrEnd(newPos, end: end, width: width, height: height) {
                possibleMoves.append(newPos)
            }
        }
        
        // Move down if current.y < end.y
        if current.1 < end.1 {
            let newPos = (current.0, current.1 + 1)
            if isInInteriorOrEnd(newPos, end: end, width: width, height: height) {
                possibleMoves.append(newPos)
            }
        }
        
        // Move up if current.y > end.y
        if current.1 > end.1 {
            let newPos = (current.0, current.1 - 1)
            if isInInteriorOrEnd(newPos, end: end, width: width, height: height) {
                possibleMoves.append(newPos)
            }
        }
        
        // Randomly shuffle for variety
        possibleMoves.shuffle()
        
        // If no valid move is found, we give up (dead-end)
        guard let next = possibleMoves.first else {
            break
        }
        
        current = next
    }
    
    // Finally, ensure the end tile is set as pathway
    dungeon.setTileType(at: end.0, y: end.1, to: .pathway)
}

// Helper to allow “end” coordinate on the edge, but keep all intermediate steps strictly inside.
private func isInInteriorOrEnd(_ pos: (Int, Int),
                               end: (Int, Int),
                               width: Int,
                               height: Int) -> Bool
{
    if pos == end {
        // The end can be on an edge
        return true
    }
    // Else, must be strictly in [1..<(width-1)] and [1..<(height-1)]
    let (x, y) = pos
    return x >= 1 && x < width - 1
        && y >= 1 && y < height - 1
}

// MARK: - Wall Logic

// If exit is on left => new entrance is on right, etc.
func oppositeWallCoordinate(exit: (Int, Int), gridSize: Int) -> (Int, Int) {
    // Reflect x=0 to x=gridSize-1, y=0 to y=gridSize-1, etc.
    let (x, y) = exit
    if x == 0 { return (gridSize - 1, y) }
    if x == gridSize - 1 { return (0, y) }
    if y == 0 { return (x, gridSize - 1) }
    if y == gridSize - 1 { return (x, 0) }
    // fallback if not on a wall
    return (0, y)
}

// Which wall is a coordinate on, if any?
func getWallOfCoordinate(_ coord: (Int, Int), gridSize: Int) -> Wall {
    let (x, y) = coord
    if x == 0 { return .left }
    if x == gridSize - 1 { return .right }
    if y == 0 { return .top }
    if y == gridSize - 1 { return .bottom }
    return .none
}

// Pick an exit on walls

func pickExitFromWalls(
    excludingWall: Wall,
    gridSize: Int,
    entrance: (Int, Int),
    minDistance: Double
) -> (Int, Int)
{
    // Potential walls (excluding the one used by the entrance)
    var candidateWalls: [Wall] = [.top, .right, .bottom, .left]
    if excludingWall != .none {
        candidateWalls.removeAll { $0 == excludingWall }
    }
    
    // All candidate coordinates on those walls (excluding corners)
    let candidates = candidateWalls
        .flatMap { $0.edgeCoordinates(gridSize: gridSize) }
        .shuffled()
    
    // Among those, keep only the ones at or beyond minDistance
    let validCandidates = candidates.filter {
        euclideanDistance($0, entrance) >= minDistance
    }
    
    // If none meet minDistance, fallback to any candidate
    guard !validCandidates.isEmpty else {
        return candidates.first ?? (gridSize - 1, gridSize / 2)
    }
    
    // Pick a random valid location (instead of always the farthest)
    return validCandidates.randomElement()!
}

// Possible walls
enum Wall {
    case top, right, bottom, left, none
    
    // Return the [ (x,y) ] along this edge (excluding corners)
    func edgeCoordinates(gridSize: Int) -> [(Int, Int)] {
        switch self {
        case .top:
            return (1..<(gridSize-1)).map { (x: $0, y: 0) }
        case .right:
            return (1..<(gridSize-1)).map { (x: gridSize-1, y: $0) }
        case .bottom:
            return (1..<(gridSize-1)).map { (x: $0, y: gridSize-1) }
        case .left:
            return (1..<(gridSize-1)).map { (x: 0, y: $0) }
        case .none:
            return []
        }
    }
}

// MARK: - Distance

func euclideanDistance(_ a: (Int, Int), _ b: (Int, Int)) -> Double {
    let dx = Double(a.0 - b.0)
    let dy = Double(a.1 - b.1)
    return sqrt(dx*dx + dy*dy)
}
