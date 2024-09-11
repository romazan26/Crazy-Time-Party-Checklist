//
//  TaskCellView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI

struct TaskCellView: View {
    @ObservedObject var task: Task
    @ObservedObject var vm: CheckListViewModel
    var body: some View {
        HStack {
            Button(action: {vm.comletedTask(task: task)}, label: {
                if task.compltd{
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: scaleScreen_x(24), height: scaleScreen_y(24))
                        .foregroundStyle(.pinkbutton)
                        .padding(.horizontal)
                }else {
                    Circle().stroke(lineWidth: 2.0)
                        .foregroundStyle(.white)
                        .frame(width: scaleScreen_x(24), height: scaleScreen_y(24))
                        .foregroundStyle(.pinkbutton)
                        .padding(.horizontal)
                }
        
            })
            
            
            Text(task.textTask ?? "")
                .foregroundStyle(.white)
            .font(.system(size: 17))
            Spacer()
        }
        .padding()
        .background {
            Color.white.opacity(0.1).cornerRadius(12)
        }
    }
}

//#Preview {
//    ZStack {
//        backForText(width: .infinity, height: 300)
//        TaskCellView(task: Task())
//    }
//        
//}
