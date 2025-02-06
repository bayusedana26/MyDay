//
//  RemindersView.swift
//  MyDay
//
//  Created by Bayu Sedana on 03/02/25.
//

import SwiftUI
import UserNotifications

struct RemindersView: View {
    // MARK: - Attributes
    @AppStorage("Reminder Time") private var reminderTime: Double = Date().timeIntervalSince1970
    
    @State private var isReminderOn: Bool = false
    @State private var selectedDate: Date = Date().addingTimeInterval(86400)
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""

    // MARK: - Methods
    /// Requests permission to send local notifications
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            DispatchQueue.main.async {
                if success {
                    print("✅ Permission granted")
                } else {
                    print("❌ Permission denied")
                    isReminderOn = false
                    alertMessage = "Notification permission denied. Please enable it in settings."
                    showingAlert = true
                }
            }
            if let error = error {
                print("⚠️ Error requesting permission: \(error.localizedDescription)")
            }
        }
    }
    
    /// Schedules a local notification based on user-selected time
    private func scheduleLocalNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus != .authorized {
                    print("❌ Notifications not authorized")
                    requestNotificationPermission()
                    return
                }
                
                let content = UNMutableNotificationContent()
                content.title = "Hey! It's time to check your tasks!"
                content.body = "Don't forget to do your work!"
                content.sound = UNNotificationSound.default
                
                let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: selectedDate)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)

                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["taskReminder"])
                
                let request = UNNotificationRequest(identifier: "taskReminder", content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { error in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("❌ Error scheduling notification: \(error.localizedDescription)")
                            alertMessage = "Failed to schedule notification."
                        } else {
                            print("✅ Notification scheduled successfully at \(selectedDate)")
                            alertMessage = "Reminder set for \(selectedDate.formatted(date: .omitted, time: .shortened))"
                        }
                        showingAlert = true
                    }
                }
            }
        }
    }
    
    /// Cancels the scheduled notification
    private func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["taskReminder"])
        print("✅ Notification canceled")
        alertMessage = "Reminder has been turned off."
        showingAlert = true
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Reminders")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Worry not to forget your tasks!")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Toggle(isOn: $isReminderOn) {
                Text("Turn on reminders")
            }
            .onChange(of: isReminderOn) { oldValue, newValue in
                if newValue {
                    scheduleLocalNotification()
                } else {
                    cancelNotification()
                }
            }
            
            HStack {
                Spacer()
                
                DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .disabled(!isReminderOn)
                    .onChange(of: selectedDate) { oldValue, newValue in
                        if oldValue != newValue {
                            scheduleLocalNotification()
                            reminderTime = selectedDate.timeIntervalSince1970
                            alertMessage = "Reminder time updated to \(selectedDate.formatted(date: .omitted, time: .shortened))"
                            showingAlert = true
                        }
                    }
            }
            
            Image("reminders")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            // Tooltip dynamically updates based on reminder state
            ToolTipView(text: isReminderOn ?
                "Reminder set for \(selectedDate.formatted(date: .omitted, time: .shortened)) ⏰" :
                "Reminders help you stay focused and productive. Turn on reminders to get notifications at a specific time."
            )
        }
        .padding(.trailing, 2)
        .onAppear {
            selectedDate = Date(timeIntervalSince1970: reminderTime)
        }
        .padding()
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    RemindersView()
}
