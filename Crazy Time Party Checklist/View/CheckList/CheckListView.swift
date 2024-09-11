//
//  CheckListView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI

struct CheckListView: View {
    let checkList: CheckList
    var body: some View {
        ZStack {
            Image(.checkListBackGround)
                .resizable()
                .ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                HStack {
                    //MARK: Title view
                    ZStack {
                        backForText(width: 190, height: 44)
                        Text("CHECKLISTS")
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .heavy))
                    }
                    Spacer()
                    
                    //MARK: Setting button
                    Image(.setting)
                        .resizable()
                        .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    //MARK: List button
                    Image(.list)
                        .resizable()
                        .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                }
                
                Spacer()
            }.padding()
        }
    }
}

#Preview {
    CheckListView(checkList: CheckList())
}
