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
                
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 24, weight: .heavy))
        }
            .frame( height: scaleScreen_y(height) )
            .frame(width: scaleScreen_y(152))

            
    }
}

#Preview {
    BackForButton(text: "EDIT")
        .background {
            Color.black
        }
}
