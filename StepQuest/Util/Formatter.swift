//
//  Formatter.swift
//  walkers
//
//  Created by Connor Hutchinson on 5/2/24.
//

import Foundation

// Format: January 1, 1990
func formattedDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d, EEEE"
    return dateFormatter.string(from: date)
}
