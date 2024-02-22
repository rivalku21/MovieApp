//
//  Lawencon_Technical_TestApp.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 20/02/24.
//

import SwiftUI

@main
struct Lawencon_Technical_TestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
