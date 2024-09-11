//
//  backForText.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI

struct backForText: View {
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        Color(.backColorText)
            .cornerRadius(24)
            .overlay {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(.white, lineWidth: 2.0)
            }
            .frame(width: scaleScreen_x(width), height: height)
    }
}

#Preview {
    backForText(width: 190, height: 44)
        .background {
            Color.black
        }
}
