//
//  ToolTipView.swift
//  MyDay
//
//  Created by Bayu Sedana on 06/02/25.
//

import SwiftUI

struct ToolTipView: View {
    // Properties
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(Color.blue)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.blue, lineWidth: 2)
                    .background(Color("light-blue"))
            }
    }
}

#Preview {
    ToolTipView(text: "Hello World!")
}
