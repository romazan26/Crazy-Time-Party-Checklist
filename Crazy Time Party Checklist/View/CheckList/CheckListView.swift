//
//  CheckListView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI

struct CheckListView: View {
    let checkList: CheckList
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: CheckListViewModel
    var body: some View {
        ZStack {
            Image(.checkListBackGround)
                .resizable()
                .ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                HStack {
                    //MARK: Back button
                    Button(action: {dismiss()}, label: {
                        Image(.backButton)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    })
                    
                    Spacer()
                    
                    //MARK: Setting button
                    Image(.setting)
                        .resizable()
                        .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    //MARK: Share button
                    Image(.shareButton)
                        .resizable()
                        .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    //MARK: List button
                    Image(.list)
                        .resizable()
                        .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                }
                //MARK: Title view
                ZStack {
                    backForText(width: .infinity, height: 68)
                    Text(checkList.nameList ?? "")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .heavy))
                }
                
                //MARK: - Task list
                if let tasks = checkList.task?.allObjects as? [Task]{
                    if tasks.isEmpty{
                        Image(.empty)
                            .resizable()
                            .frame(width: scaleScreen_x(358), height: scaleScreen_y(171))
                    }else{
                        VStack {
                            HStack{
                                Text("List of tasks")
                                Spacer()
                                Text("\(vm.getCountComplt(tasks: tasks))/\(tasks.count)")
                                    
                            }
                            .foregroundStyle(.white)
                            .font(.system(size: 17, weight: .heavy))
                            ForEach(tasks) { task in
                                TaskCellView(task: task, vm: vm)
                            }
                        }.padding()
                            .background {
                                backForText(width: 358, height: .infinity)
                            }
                            
                    }
                }
                
                Spacer()
                //MARK: - Group of button
                HStack{
                    //MARK: Delete button
                    Button {
                        vm.deleteCheckList(checkList: checkList)
                    } label: {
                        BackForButton(text: "DELETE")
                    }
                    //MARK: Edit button
                    Button {
                        vm.isPresentEditCheckList.toggle()
                    } label: {
                        BackForButton(text: "EDIT")
                    }

                }
            }
            .sheet(isPresented: $vm.isPresentEditCheckList, content: {
                EditCheckListView(vm: vm, checkList: checkList)
            })
            .padding()
            .navigationBarBackButtonHidden()
        }
    }
}

//#Preview {
//    CheckListView(checkList: CheckList())
//}
