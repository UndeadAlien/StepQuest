//
//  StepCountView.swift
//  walkers
//
//  Created by Connor Hutchinson on 5/2/24.
//

import SwiftUI

struct StepCountVC: View {
    let title: String
    let count: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack(alignment: .bottom) {
                Text("\(count)")
                    .font(.title)
                Text("steps")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct StepCountGroupVC: View {
    var stepCount1: StepCountVC
    var stepCount2: StepCountVC
    var healthManager: HealthManager
    
    var body: some View {
        HStack {
            StepCountVC(title: stepCount1.title, count: stepCount1.count)
            
            Divider()
                .frame(height: 50)
                .background(.gray)
            
            StepCountVC(title: stepCount2.title, count: stepCount2.count)
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 5)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        StepCountVC(title: "Average", count: 14054)
        
        let hm = HealthManager.shared
        let sc1 = StepCountVC(title: "Average", count: 1000)
        let sc2 = StepCountVC(title: "Best", count: 10000)
        
        StepCountGroupVC(
            stepCount1: sc1,
            stepCount2: sc2,
            healthManager: hm
        )
    }
}
