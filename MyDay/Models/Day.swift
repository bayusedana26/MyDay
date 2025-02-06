//
//  Day.swift
//  MyDay
//
//  Created by Bayu Sedana on 03/02/25.
//

import SwiftUI
import SwiftData

@Model
class Day: Identifiable {
    
    var id: String = UUID().uuidString
    var date: Date = Date()
    var activities = [Activity]()
    
    init() {
        
    }
}

extension Day {
    static func currentDayPredicate() -> Predicate<Day> {
        let calendar = Calendar.autoupdatingCurrent
        let start = calendar.startOfDay(for: Date.now)
        
        return #Predicate<Day> { $0.date >= start }
    }
}
