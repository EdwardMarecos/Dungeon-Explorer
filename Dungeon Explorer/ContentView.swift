//
//  ContentView.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/23/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var onLogout: () -> Void

    var body: some View {
        TabView {
                    DungeonView()
                        .tabItem {
                            Label("Dungeon", systemImage: "flame")
                        }

                    InventoryView()
                        .tabItem {
                            Label("Inventory", systemImage: "bag")
                        }

                    SettingsView(onLogout: onLogout)
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                        }
                }
    }
}
//        NavigationView {
//            VStack {
//                Text("Welcome to Dungeon Explorer")
//                    .font(.largeTitle)
//                    .bold()
//                    .padding(.bottom, 40)
//
//                // Start Dungeon Button
//                NavigationLink(destination: DungeonStartView()) {
//                    Text("Start Dungeon")
//                        .bold()
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .padding(.bottom, 20)
//
//                // Inventory Button
//                NavigationLink(destination: InventoryView()) {
//                    Text("Inventory")
//                        .bold()
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .padding(.bottom, 20)
//
//                // Settings Button
//                NavigationLink(destination: Text("Settings Placeholder")) {
//                    Text("Settings")
//                        .bold()
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.gray)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//            }
//            .padding()
//        }
//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}
