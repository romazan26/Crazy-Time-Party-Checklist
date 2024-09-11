//
//  EditCheckListView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import SwiftUI

struct EditCheckListView: View {
    
    @StateObject var vm: CheckListViewModel
    let checkList: CheckList
    
    var body: some View {
        ZStack {
            Color.perpuleApp.ignoresSafeArea()
            VStack(spacing: 20) {
                //MARK: - Title view
                Text("Edit the checklist")
                    .foregroundStyle(.white)
                    .font(.system(size: 17, weight: .bold))
                
                //MARK: - Name of checkList
                VStack(alignment: .leading){
                    Text("Title")
                        .foregroundStyle(.white.opacity(0.7))
                    TextField(text:  $vm.simpleCheckListName) {
                        Text("Text").foregroundStyle(.white.opacity(0.2))
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        Color.white.opacity(0.05).cornerRadius(12)
                    }

                        
                }
                
                //MARK: - List of Task
                
                VStack(alignment: .leading){
                    Text("List of tasks")
                        .foregroundStyle(.white)
                        .font(.system(size: 17, weight: .bold))
                    
                    //MARK: one more task
                    Button(action: {vm.addCelltask()}, label: {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add a task")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background {
                            Color.white.opacity(0.1).cornerRadius(12)
                        }
                        
                    })
                    
                    //MARK: - List new task
                    ForEach(vm.simpleTasks.indices, id: \.self) { i in
                        HStack {
                            NewTaskCellView(text: $vm.simpleTasks[i])
                            Button(action: {vm.simpleTasks.remove(at: i)}, label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .foregroundStyle(.pinkbutton)
                                    .frame(width: scaleScreen_x(24), height: scaleScreen_y(24))
                            })
                        }
                    }
                }
                .padding()
                .background {
                    Color.white.opacity(0.05).cornerRadius(12)
                }
                Spacer()
                
                //MARK: - Save button
                Button(action: {
                    vm.editCheckList(checkList: checkList)
                    vm.isPresentEditCheckList.toggle()
                }, label: {
                    Text("Save")
                        .foregroundStyle(.white)
                        .font(.system(size: 17))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            Color.pinkbutton.cornerRadius(12)
                        }
                    
                })
            }.padding()
        }
        .onAppear(perform: {
            vm.fillData(checkList: checkList)
        })
    }
}

#Preview {
    EditCheckListView(vm: CheckListViewModel(), checkList: CheckList())
}
