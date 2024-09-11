//
//  CheckListCell.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI

struct CheckListCell: View {
    @ObservedObject var checkList: CheckList
    var body: some View {
        ZStack {
            backForText(width: 358, height: 96)
            HStack {
                Text(checkList.nameList ?? "")
                    .foregroundStyle(.white)
                .font(.system(size: 24, weight: .heavy))
                Spacer()
                Image(.arrow)
                    .resizable()
                    .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
            }
            .padding(.horizontal)
            .padding()
        }
    }
}

#Preview {
    CheckListCell(checkList: CheckList())
}
