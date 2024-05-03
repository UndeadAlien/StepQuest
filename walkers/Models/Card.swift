//
//  Card.swift
//  walkers
//
//  Created by Connor Hutchinson on 5/1/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Card: Codable {
    @DocumentID var id: String?
    var image: String
    var motivationalQuote: String
    var goalSteps: Int
    var completed: Bool
    
    static let testData: [Card] = [
        Card(
            id: UUID().uuidString,
            image: "boss1",
            motivationalQuote: "You can do it!",
            goalSteps: 500,
            completed: true
        ),
        Card(
            id: UUID().uuidString,
            image: "boss2",
            motivationalQuote: "Keep up the good work!",
            goalSteps: 1000,
            completed: true
        ),
        Card(
            id: UUID().uuidString,
            image: "boss3",
            motivationalQuote: "You're making progress!",
            goalSteps: 5000,
            completed: false
        ),
        Card(
            id: UUID().uuidString,
            image: "boss4",
            motivationalQuote: "You're almost there!",
            goalSteps: 15000,
            completed: false
        ),
        Card(
            id: UUID().uuidString,
            image: "boss5",
            motivationalQuote: "You're doing great!",
            goalSteps: 25000,
            completed: false
        ),
        Card(
            id: UUID().uuidString,
            image: "boss6",
            motivationalQuote: "You're on fire!",
            goalSteps: 50000,
            completed: false
        ),
        Card(
            id: UUID().uuidString,
            image: "boss7",
            motivationalQuote: "Keep going!",
            goalSteps: 75000,
            completed: false
        )
    ]
}
