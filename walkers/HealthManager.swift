//
//  HealthManager.swift
//  walkers
//
//  Created by Connor Hutchinson on 4/24/24.
//

import Foundation
import HealthKit
import WidgetKit

class HealthKitManager: ObservableObject {
    static let shared = HealthKitManager()

    var healthStore = HKHealthStore()

    var stepCountToday: Int = 0
    var thisWeekSteps: [Int: Int] = [1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0]
    
    init() {
        requestAuthorization()
    }
    
    func requestAuthorization() {
        // Check if Health data is available
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Health data not available!")
            return
        }

        // Define the types of data we will be reading from Health (e.g., stepCount)
        let toReads: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
        ]

        // Asking user's permission for their Health Data
        // Note: toShare is set to nil since I'm not updating any data
        healthStore.requestAuthorization(toShare: nil, read: toReads) { success, error in
            if success {
//                self.fetchAllDatas()
            } else {
                if let error = error {
                    print("Failed to request authorization: \(error.localizedDescription)")
                } else {
                    print("Failed to request authorization for unknown reason.")
                }
            }
        }
    }
    
    func readStepCountToday() {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }

        let now = Date()
        let startDate = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: now,
            options: .strictStartDate
        )

        let query = HKStatisticsQuery(
            quantityType: stepCountType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Failed to read step count: \(error?.localizedDescription ?? "UNKNOWN ERROR")")
                return
            }

            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            self.stepCountToday = steps
            
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: now)
            self.thisWeekSteps[weekday] = steps
        }
        healthStore.execute(query)
    }


    func readStepCountThisWeek() {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        // Find the start date (Monday) of the current week
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else {
            print("Failed to calculate the start date of the week.")
            return
        }

        // Find the end date (Sunday) of the current week
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            print("Failed to calculate the end date of the week.")
            return
        }

        let predicate = HKQuery.predicateForSamples(
            withStart: startOfWeek,
            end: endOfWeek,
            options: .strictStartDate
        )

        let query = HKStatisticsCollectionQuery(
            quantityType: stepCountType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum, // fetch the sum of steps for each day
            anchorDate: startOfWeek,
            intervalComponents: DateComponents(day: 1) // interval to make sure the sum is per 1 day
        )

        query.initialResultsHandler = { _, result, error in
            guard let result = result else {
                if let error = error {
                    print("An error occurred while retrieving step count: \(error.localizedDescription)")
                }
                return
            }

            result.enumerateStatistics(from: startOfWeek, to: endOfWeek) { statistics, _ in
                if let quantity = statistics.sumQuantity() {
                    let steps = Int(quantity.doubleValue(for: HKUnit.count()))
                    let day = calendar.component(.weekday, from: statistics.startDate)
                    self.thisWeekSteps[day] = steps
                }
            }
        }

        healthStore.execute(query)
    }


    

}
