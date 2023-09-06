//
//  Dex3App.swift
//  Dex3
//
//  Created by Jimmy Ghelani on 2023-09-06.
//

import SwiftUI

@main
struct Dex3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
