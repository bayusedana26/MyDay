//
//  Activity.swift
//  MyDay
//
//  Created by Bayu Sedana on 03/02/25.
//

import SwiftUI
import SwiftData

@Model
class Activity: Identifiable {
    
    var id: String = UUID().uuidString
    var title: String = ""
    var lastUpdated: Date = Date()
    var isHidden: Bool = false
    
    init(title: String) {
        self.title = title
    }
}
