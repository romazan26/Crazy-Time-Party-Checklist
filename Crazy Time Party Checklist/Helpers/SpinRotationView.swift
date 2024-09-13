//
//  SpinRotationView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 12.09.2024.
//

import SwiftUI

struct SpinRotationView: View {
    
    var degrees: Double = 0
    var width: CGFloat = 368
    var height: CGFloat = 417
    var wheel: UIImage
    var spin: UIImage
    
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                Image(uiImage: spin)
                    .resizable()
                    .frame(width: scaleScreen_y(width) , height: scaleScreen_y(height))
                Image(uiImage: wheel)
                    .resizable()
                    .frame(width: scaleScreen_y(width) , height: scaleScreen_y(height - 48))
                    .rotationEffect(.degrees(degrees))
                Image(.arrowSpin)
                    .resizable()
                    .frame(width: scaleScreen_y(40), height: scaleScreen_y(38))
            }
            .animation(.spring(duration: 2, bounce: 0.2), value: degrees)
//            Button("Spin") {
//                degrees = Double.random(in: 0...360)
//            }
//            Button("Spin") {
//                degrees = 325
//            }
        }
    }
}

#Preview {
    SpinRotationView(wheel: UIImage(resource: .wheel1), spin: UIImage(resource: .spin1))
}
