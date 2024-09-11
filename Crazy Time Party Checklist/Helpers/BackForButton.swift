//
//  BackForButton.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI

struct BackForButton: View {
    var text: String
    var height: CGFloat = 68
    var body: some View {
        ZStack {
            Image(.backForButton)
                .resizable()
                .cornerRadius(24)
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(.white, lineWidth: 2.0)
                }
                .frame( height: scaleScreen_y(height) )
            .frame(maxWidth: .infinity)
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 24, weight: .heavy))
        }
    }
}

#Preview {
    BackForButton(text: "EDIT")
        .background {
            Color.black
        }
}
