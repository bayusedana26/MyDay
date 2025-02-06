//
//  ActivitiesView.swift
//  MyDay
//
//  Created by Bayu Sedana on 03/02/25.
//

import SwiftUI
import SwiftData

struct ActivitiesView: View {
    // Attributes
    @Environment(\.modelContext) private var context
    
    @Query(filter: Day.currentDayPredicate(), sort: \.date)
        private var today: [Day]
    
    @Query(filter: #Predicate<Activity> { $0.isHidden == false })
        private var activities: [Activity]
    
    @State private var addView: Bool = false
    
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
    
    private func deleteActivity(at offsets: IndexSet) {
        for index in offsets {
            let activity = activities[index]
            context.delete(activity)
        }
        try? context.save()
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Activities")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Activities that will make your day better and organized!")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if activities.count == 0 {
                // Display Image and some tips
                Image("activities")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                ToolTipView(text: "You don't have any activity yet. Let's add some!")
            } else {
                List {
                    ForEach(activities) { activity in
                        let today = getToday()
                        
                        HStack {
                            Text(activity.title)
                            
                            Spacer()
                            
                            Button {
                                if today.activities.contains(activity) {
                                    // Remove from today
                                    today.activities.removeAll { $0 == activity }
                                    try? context.save()
                                } else {
                                    // Add activity to today
                                    today.activities.append(activity)
                                }
                            } label: {
                                // If already in today, show solid checkmark
                                if today.activities.contains(activity) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.blue)
                                } else {
                                    Image(systemName: "checkmark.circle")
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteActivity) // <-- Slideable delete action
                }
                .listStyle(.plain)
            }
            
            Spacer()
            
            Button("Add New Activity") {
                // MARK: - Show sheet to add new activity
                addView.toggle()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
        }
        .sheet(isPresented: $addView, content: {
            AddActivityView()
                .presentationDetents([.fraction(0.2)])
        })
        .padding()
    }
}

#Preview {
    ActivitiesView()
}
