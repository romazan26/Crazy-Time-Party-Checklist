//
//  NewTaskCellView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI

struct NewTaskCellView: View {
    @Binding var text: String
    var body: some View {
        
            TextField(text: $text) {
                Text("Text")
                    .foregroundStyle(.white.opacity(0.2))
            }
            .padding()
            .background {
                Color.white.opacity(0.1).cornerRadius(12)
            }
    }
}

#Preview {
    NewTaskCellView(text: .constant("sing"))
        .background {
            Color.black.ignoresSafeArea()
        }
}
