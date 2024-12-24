//
//  InventoryView.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/23/24.
//

import SwiftUI

struct InventoryView: View {
    @State private var items = [
        "Health Potion",
        "Sword of Valor",
        "Shield of Light"
    ]

    var body: some View {
        VStack {
            Text("Inventory")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 20)

            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .padding()
    }
}

#Preview {
    InventoryView()
}
