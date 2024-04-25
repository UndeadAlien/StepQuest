//
//  walkersApp.swift
//  walkers
//
//  Created by Connor Hutchinson on 4/24/24.
//

import SwiftUI

@main
struct walkersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(healthKitManager: HealthKitManager.shared)
        }
    }
}
