//
//  TorreonVerdeApp.swift
//  TorreonVerde
//
//  Created by Sofia on 20/10/26.
//

import SwiftUI
import SwiftData

@main
struct TorreonVerdeApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Reporte.self)
    }
}
