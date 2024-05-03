//
//  CardVM.swift
//  walkers
//
//  Created by Connor Hutchinson on 5/2/24.
//

import Foundation

class CardVM: ObservableObject {
    @Published var currentCard: Card?
    
    var totalSteps: Int {
        return HealthManager.shared.totalStepCount
    }

    var progress: Double {
        guard let currentCard = currentCard, currentCard.goalSteps != 0 else {
            return 0.0
        }
        return min(Double(totalSteps) / Double(currentCard.goalSteps), 1.0)
    }

    var difference: Int {
        guard let currentCard = currentCard else {
            return 0
        }
        return max(currentCard.goalSteps - totalSteps, 0)
    }

    var completed: Bool {
        guard let currentCard = currentCard else {
            return false
        }
        return totalSteps >= currentCard.goalSteps
    }
    
    func updateCard() {
        // Filter the testData to get only the incomplete cards sorted by goal steps in ascending order
        let incompleteCards = Card.testData.filter { !$0.completed }.sorted(by: { $0.goalSteps < $1.goalSteps })
        
        // Find the first incomplete card whose goal steps are greater than your current steps
        if let lowestGoalCard = incompleteCards.first(where: { $0.goalSteps > totalSteps }) {
            // Update the current card only if it's different from the lowest boss with higher goal steps
            currentCard = lowestGoalCard
        } else {
            // If all incomplete cards have lower or equal goal steps than your current steps, set current card to nil
            currentCard = nil
        }
    }

}
