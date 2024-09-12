//
//  SpinRotationView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 12.09.2024.
//

import SwiftUI

struct SpinRotationView: View {
    @State private var degrees: Double = 0
    var wheel: UIImage
    var spin: UIImage
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                Image(uiImage: spin)
                    .resizable()
                    .frame(width: scaleScreen_x(368), height: scaleScreen_y(417))
                Image(uiImage: wheel)
                    .resizable()
                    .frame(width: scaleScreen_x(368), height: scaleScreen_y(368))
                    .rotationEffect(.degrees(degrees))
                Image(.arrowSpin)
                    .resizable()
                    .frame(width: scaleScreen_x(47), height: scaleScreen_y(42))
            }
            .animation(.spring(duration: 2, bounce: 0.2), value: degrees)
        }
    }
}

#Preview {
    SpinRotationView(wheel: UIImage(resource: .wheel1), spin: UIImage(resource: .spin1))
}
