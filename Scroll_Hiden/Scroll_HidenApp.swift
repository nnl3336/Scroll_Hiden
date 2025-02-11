//
//  Scroll_HidenApp.swift
//  Scroll_Hiden
//
//  Created by Yuki Sasaki on 2025/02/11.
//

import SwiftUI

@main
struct Scroll_HidenApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
