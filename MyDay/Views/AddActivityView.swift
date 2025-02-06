//
//  AddActivityView.swift
//  MyDay
//
//  Created by Bayu Sedana on 03/02/25.
//

import SwiftUI
import SwiftData

struct AddActivityView: View {
    // Attributes
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var title: String = ""
    
    // Methods
    private func addActivity() {
        // Clean text
        let cleanTitle = title.trimmingCharacters(in: .whitespaces)
        
        // Add to Data
        context.insert(Activity(title: cleanTitle))
        
        try? context.save()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("What do you want to do today?", text: $title)
                .textFieldStyle(.roundedBorder)
            
            // Add to SwiftData
            Button("Add") {
                addActivity()
                
                title = ""
                
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .center)
            .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding()
    }
}

#Preview {
    AddActivityView()
}
