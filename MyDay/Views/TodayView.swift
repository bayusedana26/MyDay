//
//  TodayView.swift
//  MyDay
//
//  Created by Bayu Sedana on 03/02/25.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    // Attributes
    @Environment(\.modelContext) private var context
    
    @Binding var selectedTab: Tab
    
    @Query(filter: Day.currentDayPredicate(), sort: \.date)
        private var today: [Day]
    
    // Method
    private func getToday() -> Day {
        // Retrieve data from DB. If not exist, create and insert it
        if today.count > 0 {
            return today.first!
        } else {
            let today = Day()
            context.insert(today)
            try? context.save()
            
            return today
        }
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("Today")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("List of today activity")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Display checkmarked list
            if getToday().activities.count > 0 {
                List(getToday().activities) { activity in
                    Text(activity.title)
                }
                .listStyle(.plain)
            } else {
                // Display Image and some tips
                Spacer()
                Image("today")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                                
                ToolTipView(text: "Remember, just be yourself and do your best!")
                
                Button {
                    // Nav to activity view
                    selectedTab = Tab.activity
                } label: {
                    Text("Log")
                }
                .buttonStyle(.borderedProminent)

                
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    TodayView(selectedTab: Binding.constant(Tab.today))
}
