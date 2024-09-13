//
//  SpinView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 12.09.2024.
//

import SwiftUI

struct SpinView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = SpinViewModel()
    
    
    var body: some View {
        ZStack {
            //MARK: - Background
            Image(uiImage: vm.simpleBackGround)
                .resizable()
                .ignoresSafeArea()
            VStack {
                //MARK: - Top tool bar
                HStack {
                    //MARK: Title view
                    ZStack {
                        backForText(width: 131, height: 44)
                        Text("WHEELL")
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .heavy))
                    }
                    Spacer()
                    
                    //MARK: Setting button
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(.setting)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }
                    //MARK: Menu button
                    Button {
                        dismiss()
                    } label: {
                        Image(.list)
                            .resizable()
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                    }
                }
                if vm.spinsFortune.isEmpty || vm.pageIndex >= vm.spinsFortune.count {
                    Text("YOUR GAME")
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .heavy))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background {
                            backForText(width: 324, height: .infinity)
                        }
                    
                    //MARK: - Spin
                    
                    Spacer()
                    Image(.noSpinGame)
                        .resizable()
                        .frame(width: scaleScreen_y(368), height: scaleScreen_y(417))
                        .onAppear(perform: {
                            vm.simpleBackGround = .noSpinBack
                        })
                    //MARK: Navigation back button
                    if !vm.spinsFortune.isEmpty{
                        HStack{
                            Button {vm.pageIndex -= 1} label: {
                                Image(.buttonLeft)
                                    .resizable()
                            }
                            .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                            
                            Spacer()
                        }.frame(width: scaleScreen_x(150))
                    }
                    
                    Spacer()
                    
                    //MARK: - Create button
                    Button {
                        vm.isPresentCreate.toggle()
                    } label: {
                        BackForButton(text: "CREATE A GAME")
                    }
                    
                }else{
                    VStack {
                        Text(vm.spinsFortune[vm.pageIndex].nameGame ?? "")
                            .foregroundStyle(.white)
                            .font(.system(size: 24, weight: .heavy))
                            .multilineTextAlignment(.center)
                            .padding()
                            .background {backForText(width: 324, height: .infinity)}
                        
                        TabView(selection: $vm.pageIndex,
                                content:  {
                            ForEach(vm.spinsFortune.indices, id: \.self) { i in
                                PageSpinView(pageSpin: vm.spinsFortune[i])
                                    .onAppear(perform: {
                                        vm.simpleBackGround = vm.spinsFortune[i].backGround ?? UIImage(resource: .noSpinBack)
                                    })
                                    .tag(i)
                            }
                        })
                        .animation(.easeInOut, value: vm.pageIndex)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        //MARK: - Navigation button
                        HStack{
                            if vm.pageIndex > 0{
                                Button {
                                    vm.pageIndex -= 1
                                } label: {
                                    Image(.buttonLeft)
                                        .resizable()
                                }
                                .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                            }
                            Spacer()
                            if vm.spinsFortune.count > vm.pageIndex {
                                Button {
                                    vm.pageIndex += 1
                                    print(vm.spinsFortune)
                                    
                                } label: {
                                    Image(.buttonRight)
                                        .resizable()
                                }
                                .frame(width: scaleScreen_x(56), height: scaleScreen_y(56))
                            }
                            
                        }.frame(width: scaleScreen_x(150))
                        
                        //MARK: - buttons
                        HStack {
                            Button {
                                vm.isPresentEdit.toggle()
                            } label: {
                                BackForButton(text: "EDIT")
                            }
                            NavigationLink {
                                StartSpinView( vm: vm, spin: vm.spinsFortune[vm.pageIndex])
                            } label: {
                                BackForButton(text: "START")
                            }
                            
                        }
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        //MARK: - Sheets
        .sheet(isPresented: $vm.isPresentEdit, content: {
            EditSpinView(vm: vm, spinFortune: vm.spinsFortune[vm.pageIndex])
        })
        .sheet(isPresented: $vm.isPresentCreate, content: {
            CreateSpinView(vm: vm)
        })
    }
}

#Preview {
    NavigationView {
        SpinView()
    }
}
