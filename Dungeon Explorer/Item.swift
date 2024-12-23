//
//  Item.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/23/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
