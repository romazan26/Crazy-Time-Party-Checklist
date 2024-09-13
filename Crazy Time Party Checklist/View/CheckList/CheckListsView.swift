//
//  CheckListView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 10.09.2024.
//

import SwiftUI

struct CheckListsView: View {
    
    @ObservedObject var vm = CheckListViewModel()
    @Environment(\.dismiss) var dismiss
    
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
                    NavigationLink {
                        SettingsView().onAppear(perform: {
                            SoundManager.instance.playSound(sound: .button)
                        })
                    } label: {
                        Image(.setting)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }

                    
                    //MARK: Menu button
                    Button {
                        dismiss()
                        SoundManager.instance.playSound(sound: .button)
                    } label: {
                        Image(.list)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }
                }
                
                //MARK: - Count cheklist
                CountCheklist(count: vm.checkLists.count)
                
                //MARK: - CheckLists List
                if vm.checkLists.isEmpty{
                    Image(.empty)
                        .resizable()
                        .frame(width: scaleScreen_x(358), height: scaleScreen_y(171))
                }else{
                    ScrollView {
                        ForEach(vm.checkLists) { checkList in
                            NavigationLink {
                                CheckListView(checkList: checkList, vm: vm)
                                    .onAppear(perform: {
                                        SoundManager.instance.playSound(sound: .button)
                                    })
                            } label: {
                                CheckListCell(checkList: checkList)
                            }
                        }
                    }
                }
                Spacer()
                
                //MARK: - Add buttom
                Button {
                    vm.isPresentAddCheckList.toggle()
                    SoundManager.instance.playSound(sound: .button)
                } label: {
                    ZStack{
                        backForText(width: 320, height: 68)
                        Text("ADD A CHECKLIST")
                            .foregroundStyle(.white)
                            .font(.system(size: 24, weight: .heavy))
                    }
                }
            }
            .padding()
            .navigationBarBackButtonHidden()
        }
        .sheet(isPresented: $vm.isPresentAddCheckList, content: {
            AddCheckListView(vm: vm)
        })
    }
}

#Preview {
    NavigationView {
        CheckListsView()
    }
}
