//
//  ContentView.swift
//  walkers
//
//  Created by Connor Hutchinson on 4/24/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @ObservedObject var healthKitManager: HealthKitManager

    var body: some View {
        TabView {
            DashboardView(healthKitManager: healthKitManager)
                .onAppear {
                    healthKitManager.requestAuthorization()
                }
                .tabItem {
                    Label("Steps", systemImage: "figure.walk.circle.fill")
                }
        }
    }
}


#Preview {
    ContentView(healthKitManager: HealthKitManager.shared)
}
