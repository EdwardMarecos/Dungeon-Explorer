//
//  Dungeon_ExplorerApp.swift
//  Dungeon Explorer
//
//  Created by Edward Marecos on 12/23/24.
//

import SwiftUI
import SwiftData

// auth
import AuthenticationServices

// firebase
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Dungeon_ExplorerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var isLoggedIn = false
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView(onLogout: {
                    isLoggedIn = false // Set to false on logout
                })
            } else {
                LoginView(onLogin: {
                    isLoggedIn = true // Set to true on login
                })
            }
        }
    }
}
