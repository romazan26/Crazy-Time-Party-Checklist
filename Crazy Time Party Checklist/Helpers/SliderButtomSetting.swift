//
//  SliderButtomSetting.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import Foundation
import SwiftUI

struct SliderButtomSetting: View {
    var text: String
    @Binding var value: Double
    var body: some View {
        HStack{
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
            Spacer()
            SwiftUISlider(thumbColor: .white,
                          minTrackColor: .pinkbutton,
                          maxTrackColor: .gray,
                          value: $value)
                .frame(width: scaleScreen_x(108))
        }
        .frame(width: scaleScreen_x(234))
    }
}
