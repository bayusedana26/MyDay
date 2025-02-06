//
//  MyDayApp.swift
//  MyDay
//
//  Created by Bayu Sedana on 03/02/25.
//

import SwiftUI

@main
struct MyDayApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [Day.self, Activity.self])
        }
    }
}
