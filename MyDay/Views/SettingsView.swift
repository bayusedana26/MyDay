//
//  SettingsView.swift
//  MyDay
//
//  Created by Bayu Sedana on 03/02/25.
//

import SwiftUI

struct SettingsView: View {
    // Methods
    
    private func createMailUrl() -> URL? {
        var mailUrlComponents = URLComponents()
        mailUrlComponents.scheme = "mailto"
        mailUrlComponents.path = "developwithbayu@gmail.com"
        mailUrlComponents.queryItems = [
            URLQueryItem(name: "subject", value: "Feedback from MyDay"),
        ]
        
        return mailUrlComponents.url
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .bold()
            
            List {
                // Rate the app
                let reviewUrl = URL(string: "https://apps.apple.com/id/app/amazon-prime-video/id545519333?action=write-review")!
                
                Link(destination: reviewUrl) {
                    HStack {
                        Image(systemName: "star.bubble")
                        Text("Rate the app")
                    }
                }
                
                // Recommend the app
                let shareUrl = URL(string: "https://apps.apple.com/id/app/amazon-prime-video/id545519333")!
                
                ShareLink(item: shareUrl) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right")
                        Text("Recommend the app")
                    }
                }
                
                // Contact
                Button {
                    // Compose email
                    let mailUrl = createMailUrl()
                    
                    if let mailUrl = mailUrl,
                       UIApplication.shared.canOpenURL(mailUrl) {
                        UIApplication.shared.open(mailUrl)
                    } else {
                        print("Couldn't open client email")
                    }
                } label: {
                    HStack {
                        Image(systemName: "quote.bubble")
                        Text("Submit feedback")
                    }
                }
                
                let privacyUrl = URL(string: "https://google.com")!
                
                Link(destination: privacyUrl) {
                    HStack {
                        Image(systemName: "lock.shield")
                        Text("Privacy Policy")
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
            .tint(.black)
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
