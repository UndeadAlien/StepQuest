//
//  HealthAuthView.swift
//  walkers
//
//  Created by Connor Hutchinson on 5/1/24.
//

import SwiftUI
import HealthKit

class HealthManager: ObservableObject {
    static let shared = HealthManager()
    
    private let healthStore: HKHealthStore
    
    @Published var totalStepCount: Int = 0
    
    init() {
        guard HKHealthStore.isHealthDataAvailable() else {
            fatalError("This app requires a device that supports HealthKit")
        }
        healthStore = HKHealthStore()
        requestHealthkitPermissions()
    }
    
    private func requestHealthkitPermissions() {
        let allTypes = Set([
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
        ])
        
        healthStore.requestAuthorization(toShare: nil, read: allTypes) { (success, error) in
            print("Request Authorization -- Success: ", success, " Error: ", error ?? "nil")
        }
    }
    
    func observeTotalStepCount() {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            fatalError("*** Unable to get the step count type ***")
        }
        
        let observerQuery = HKObserverQuery(sampleType: stepCountType, predicate: get24hPredicate()) { [weak self] (query, completionHandler, error) in
            guard let self = self else { return }
            
            self.readTotalStepCount()
            
            completionHandler()
        }
        
        healthStore.execute(observerQuery)
    }

    private func readTotalStepCount() {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            fatalError("*** Unable to get the step count type ***")
        }
        
        let query = HKStatisticsQuery.init(
            quantityType: stepCountType,
            quantitySamplePredicate: get24hPredicate(),
            options: [HKStatisticsOptions.cumulativeSum]
        ) { [weak self] (query, results, error) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                let totalStepCount = results?.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
                self.totalStepCount = Int(totalStepCount)
            }
        }
        
        healthStore.execute(query)
    }

    private func get24hPredicate() -> NSPredicate{
        let today = Date()
        let startDate = Calendar.current.date(byAdding: .hour, value: -24, to: today)
        let predicate = HKQuery.predicateForSamples(withStart: startDate,end: today,options: [])
        return predicate
    }
}
