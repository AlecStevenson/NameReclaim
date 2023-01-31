//
//  NameReclaimApp.swift
//  NameReclaim
//
//  Created by alec stevenson on 10/10/22.
//

import SwiftUI

@main
struct NameReclaimApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

}
var tempNum = Int64()

