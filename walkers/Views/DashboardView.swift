//
//  DashboardView.swift
//  walkers
//
//  Created by Connor Hutchinson on 4/24/24.
//

import SwiftUI

enum ProgressFilter: String, CaseIterable {
    case today
    case week
    case month
    
    var id: RawValue { rawValue }
}

struct DashboardView: View {
    @ObservedObject var healthManager = HealthManager.shared
    @ObservedObject var cardVM = CardVM()
    
    @State private var selectedFilter: ProgressFilter = .today
    
    @State var coinCount: Int = 0
    
    private var todaysDate = Date()

    var body: some View {
        NavigationStack {
            HeaderVC(coinCount: coinCount, todaysDate: todaysDate)
            if let card = cardVM.currentCard {
                CardVC(
                    card: card,
                    currentSteps: healthManager.totalStepCount,
                    viewModel: cardVM
                )
            }
            progress
            Spacer()
        }
        .onAppear {
            healthManager.observeTotalStepCount()
            cardVM.updateCard()
        }
    }
    
    var progress: some View {
        VStack(spacing: 20) {
            Text("Your Steps Progress")
                .font(.title3)
                .bold()
            
            Picker("", selection: $selectedFilter) {
                ForEach(ProgressFilter.allCases, id: \.self) { pf in
                    Text(pf.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            StepCountGroupVC(
                stepCount1: StepCountVC(title: "Average", count: Int(healthManager.totalStepCount)),
                stepCount2: StepCountVC(title: "Best", count: Int(healthManager.totalStepCount)),
                healthManager: healthManager
            )
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    DashboardView()
}
