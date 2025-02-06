//
//  HomeView.swift
//  MyDay
//
//  Created by Bayu Sedana on 03/02/25.
//

import SwiftUI
import SwiftData

enum Tab: Int {
    case today = 0
    case activity = 1
    case reminders = 2
    case settings = 3
}

struct HomeView: View {
    // Attributes
    @State var selectedTab: Tab = Tab.today
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            TodayView(selectedTab: $selectedTab)
                .tabItem {
                    Text("Today")
                    Image(systemName: "calendar")
                }
                .tag(Tab.today)
            
            ActivitiesView()
                .tabItem {
                    Text("Activity")
                    Image(systemName: "list.bullet")
                }
                .tag(Tab.activity)
            
            RemindersView()
                .tabItem {
                    Text("Reminders")
                    Image(systemName: "bell")
                }
                .tag(Tab.reminders)
            
            SettingsView()
                .tabItem {
                    Text("Settings")
                    Image(systemName: "gearshape")
                }
                .tag(Tab.settings)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
