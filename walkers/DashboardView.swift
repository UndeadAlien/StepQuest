//
//  DashboardView.swift
//  walkers
//
//  Created by Connor Hutchinson on 4/24/24.
//

import SwiftUI

class DashboardVM: ObservableObject {
    @Published var coin_count: Int = 0
}

struct DashboardView: View {
    @StateObject var viewModel = DashboardVM()
    @ObservedObject var healthKitManager: HealthKitManager
    
    var todaysDate = Date()
    
    var body: some View {
        NavigationStack {
            header
            Spacer()
            progress
        }
    }
    
    var header: some View {
        // header
        VStack {
            HStack {
                // profile image
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 38, height: 38)
                    .foregroundStyle(.gray)
                
                Spacer()
                HStack {
                    Text("\(viewModel.coin_count)")
                        .font(.headline)
                        .bold()
                    if let image = UIImage(named: "basic_token") {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 25)
            
            VStack(alignment: .leading) {
                Text("\(formattedDate(date: todaysDate))")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 10)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .opacity(0.4)
            }
        }
    }
    
    var content: some View {
        // quest
        VStack {}
    }
    
    var progress: some View {
        VStack {
            Text("Your steps progress")
                .font(.title3)
                .bold()
            
            HStack {
                VStack {
                    Text("Daily")
                    Text("\(healthKitManager.stepCountToday) steps")
                }
                Divider()
                VStack {
                    Text("Weekly")
                    Text("\(healthKitManager.thisWeekSteps) steps")
                }
            }
        }
    }
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, EEEE"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    DashboardView(healthKitManager: HealthKitManager.shared)
}
