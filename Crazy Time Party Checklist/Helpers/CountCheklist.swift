//
//  CountCheklist.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI

struct CountCheklist: View {
    var count: Int
    var body: some View {
        ZStack{
            backForText(width: 358, height: 158)
            HStack{
                Image(.candy)
                    .resizable()
                    .frame(width: scaleScreen_x(98), height: scaleScreen_y(98))

                Spacer()
                VStack{
                    Text("\(count)")
                        .foregroundStyle(.white)
                        .font(.system(size: 40, weight: .heavy))
                    Text("COUNT OF CHEKLIST")
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.system(size: 16, weight: .bold))
                }
                Spacer()
            }.padding()
        }
    }
}

#Preview {
    CountCheklist(count: 12)
}
