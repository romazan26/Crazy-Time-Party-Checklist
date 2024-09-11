//
//  ButtonMenuView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 10.09.2024.
//

import SwiftUI

struct ButtonMenuView: View {
    @State var image: ImageResource
    
    var firstImage: ImageResource
    var secondImage: ImageResource
    var text = ""
    @State var action: () -> Void
    
    var body: some View {
        ZStack{
            Image(image)
                .resizable()
                .frame(width: scaleScreen_x(264), height: scaleScreen_y(72))
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 24, weight: .heavy, design: .monospaced))
        }
        .pressEvents {
            withAnimation(.bouncy(duration: 0.2)) {
                image = secondImage
            }
            
        } onRelease: {
            withAnimation {
                image = firstImage
            }
            action()
        }

    }
}

#Preview {
    ButtonMenuView(image: .button1,
                   firstImage: .button1,
                   secondImage: .button12,
                   text: "TRAINING",
                   action: {})
}
