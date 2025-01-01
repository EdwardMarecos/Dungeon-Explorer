//
//  DungeonGridView.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/26/24.
//

import SwiftUI

struct DungeonGridView: View {
    let dungeon: DungeonGrid

    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<dungeon.grid.count, id: \.self) { x in
                HStack(spacing: 2) {
                    ForEach(0..<dungeon.grid[x].count, id: \.self) { y in
                        let tile = dungeon.grid[x][y]
                        Rectangle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(color(for: tile.type))
                    }
                }
            }
        }
        .padding()
    }

    // Changed to highlight start/end more distinctly
    private func color(for type: TileType) -> Color {
        switch type {
        case .wall:     return .gray
        case .pathway:  return .yellow
        case .enemy:    return .red
        case .treasure: return .green
        case .start:    return .mint   // or any bright color
        case .end:      return .orange // or another distinct color
        }
    }
}
