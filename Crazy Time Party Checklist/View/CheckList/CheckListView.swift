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
    @State private var isPresentAlert = false
    var body: some View {
        ZStack {
            Image(.checkListBackGround)
                .resizable()
                .ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                HStack {
                    //MARK: Back button
                    Button(action: {
                        dismiss()
                        SoundManager.instance.playSound(sound: .button)
                    }, label: {
                        Image(.backButton)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    })
                    
                    Spacer()
                    
                    //MARK: Setting button
                    NavigationLink {
                        SettingsView().onAppear(perform: {
                            SoundManager.instance.playSound(sound: .button)
                        })
                    } label: {
                        Image(.setting)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }

                    //MARK: Share button
                    Image(.shareButton)
                        .resizable()
                        .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    //MARK: List button
                    Button(action: {
                        dismiss()
                        SoundManager.instance.playSound(sound: .button)
                    }, label: {
                        Image(.list)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    })
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
                        isPresentAlert.toggle()
                        SoundManager.instance.playSound(sound: .button)
                    } label: {
                        BackForButton(text: "DELETE")
                    }
                    //MARK: Edit button
                    Button {
                        vm.isPresentEditCheckList.toggle()
                        SoundManager.instance.playSound(sound: .button)
                    } label: {
                        BackForButton(text: "EDIT")
                    }

                }
            }
            .alert(isPresented: $isPresentAlert, content: {
                Alert(title: Text("Delete"),
                      message: Text("Are you sure you want to delete the checklist?"),
                      primaryButton: .default(Text("Delete"), action: {
                    vm.deleteCheckList(checkList: checkList)
                }),
                      secondaryButton: .cancel())
            })
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
