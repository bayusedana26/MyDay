# MyDay

## 📌 Overview
**MyDay** is a simple yet powerful reminders app that helps users input their daily activities and set notifications to stay on track. The app ensures users never forget important tasks by providing a seamless experience for logging activities and scheduling reminders.

## ✨ Features
- 📅 **Activity Management**: Users can log daily activities and view them in an organized list.
- ⏰ **Reminders & Notifications**: Set time-based reminders with customizable schedules.
- 🔔 **Dynamic UI Feedback**: The app displays a bell icon and reminder time when a notification is set.
- 📊 **Persistent Data Storage**: Uses SwiftData to store activities and reminder settings.
- 🖼️ **Engaging UI**: Includes helpful images and tooltips for better user guidance.

## 🛠️ Technologies Used
- **SwiftUI** – For building the user interface.
- **SwiftData** – For local data persistence.
- **UserNotifications** – To schedule and manage notifications.

## 📂 Project Structure
```
MyDay/
├── Models/
│   ├── Day.swift
│   ├── Activity.swift
├── Views/
│   ├── HomeView.swift
│   ├── TodayView.swift
│   ├── ActivitiesView.swiff
│   ├── AddActivitiesView.swift
│   ├── RemindersView.swift
│   ├── SettingsView.swift
│   ├── ToolTipView.swift
├── Resources/
│   ├── Assets.xcassets
│   ├── AppIcon
│   ├── Images
```

## 📲 How to Use
1. **Log an Activity**: Navigate to the "Activity" tab and add a new activity.
2. **Set a Reminder**: Go to the "Reminders" tab, enable notifications, and select a time.
3. **Receive Notifications**: A scheduled reminder will notify users at the selected time.
4. **Manage Activities**: View and check off completed tasks in the "Today" tab.

## 🚀 Future Improvements
- 📝 **Repeat Reminders**: Add support for recurring tasks.
- 🔄 **Siri Integration**: Enable voice-based activity logging.
- 📌 **Widgets & Lock Screen Reminders**: Display upcoming reminders directly on the home screen.

## 🏗️ Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/MyDay.git
   ```
2. Open **MyDay.xcodeproj** in Xcode.
3. Run the project on an iOS simulator or device.

## 📜 License
This project is licensed under the MIT License. Feel free to use and modify it as needed!

---
💡 *"Stay productive with MyDay! Never miss a task again."*

