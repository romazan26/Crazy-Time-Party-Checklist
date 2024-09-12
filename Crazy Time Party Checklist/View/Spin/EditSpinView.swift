//
//  EditSpinView.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 12.09.2024.
//

import SwiftUI

struct EditSpinView: View {
    @ObservedObject var vm: SpinViewModel
    @State private var isPresentAlert = false
    
    let spinFortune: SpinFortune
    
    var body: some View {
        ZStack {
            Color.perpuleApp.ignoresSafeArea()
            VStack(spacing: 20) {
                //MARK: - Title view
                Text("The name of the game")
                    .foregroundStyle(.white)
                    .font(.system(size: 17, weight: .bold))
                
                //MARK: - Name of game
                VStack(alignment: .leading){
                    Text("Title")
                        .foregroundStyle(.white.opacity(0.7))
                    TextField(text:  $vm.simpleNameGame) {
                        Text("Text").foregroundStyle(.white.opacity(0.2))
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background {
                        Color.white.opacity(0.05).cornerRadius(12)
                    }
                    
                    
                }
                
                //MARK: - Background
                VStack(alignment: .leading) {
                    //Title
                    Text("Background")
                        .foregroundStyle(.white.opacity(0.7))
                    //Image
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(SpinBack.allCases, id: \.self) { image in
                                Button(action: {vm.simpleBackGround = UIImage(resource: image.image) }, label: {
                                    ZStack {
                                        Image(image.image)
                                            .resizable()
                                        
                                            .cornerRadius(12)
                                            .padding(2)
                                        if vm.simpleBackGround == UIImage(resource: image.image){
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(.pinkbutton.opacity(0.5), lineWidth: 3.0)
                                        }
                                    }.frame(width: scaleScreen_x(60), height: scaleScreen_y(130))
                                })
                                
                            }
                        }
                    }
                }
                
                //MARK: - Color spin
                VStack(alignment: .leading) {
                    //Title
                    Text("Wheel color")
                        .foregroundStyle(.white.opacity(0.7))
                    //Image
                    HStack {
                        ForEach(SpinColor.allCases, id: \.self) { color in
                            Button(action: {vm.simpleColor = color}, label: {
                                ZStack{
                                    Image(color.spinColor)
                                        .resizable()
                                    if vm.simpleColor == color{
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(.pinkbutton.opacity(0.5), lineWidth: 2.0)
                                    }
                                }.frame(width: scaleScreen_x(60), height: scaleScreen_y(60))
                            })
                            
                        }
                        Spacer()
                    }
                }
                //MARK: - Tasks
                ScrollView {
                    VStack{
                        HStack{
                            Text("List of tasks").foregroundStyle(.white)
                            Spacer()
                            Text("\(vm.countTask)/16").foregroundStyle(.white)
                        }
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
                }
                
                HStack {
                    //MARK: - Save button
                    HStack {
                        Button(action: {
                            isPresentAlert.toggle()
                        }, label: {
                            Text("Delete")
                                .foregroundStyle(.white)
                                .font(.system(size: 17))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background {
                                    Color.white.opacity(0.05).cornerRadius(12)
                                }
                            
                        })
                        Button(action: {
                             vm.editSpinFortune(spin: spinFortune)
                              vm.isPresentEdit.toggle()
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
                    }
                }
                
            }
            .padding()
            .alert(isPresented: $isPresentAlert, content: {
                Alert(title: Text("Delete"),
                      message: Text("Are you sure you want to delete the Game?"),
                      primaryButton: .default(Text("Delete"), action: {
                    vm.deleteSpinList(spin: spinFortune)
                    vm.isPresentEdit.toggle()
                }),
                      secondaryButton: .cancel())
            })
        }
        .onAppear(perform: {
            vm.fillData(spin: spinFortune)
        })
    }
}

//#Preview {
//    EditSpinView(vm: SpinViewModel())
//}
