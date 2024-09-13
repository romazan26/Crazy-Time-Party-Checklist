//
//  SpinViewModel.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 12.09.2024.
//

import Foundation
import CoreData
import SwiftUI



final class SpinViewModel: ObservableObject{
    
    @AppStorage("isFirstSpin") var isFirstSpin: Bool?
    
    let manager = CoreDataManager.instance
    
    @Published var spinsFortune: [SpinFortune] = []
    @Published var tasks: [Task] = []
    
    @Published var pageIndex = 0
    @Published var simpleBackGround = UIImage(resource: .noSpinBack)
    @Published var simpleNameGame = ""
    @Published var simpleColor = SpinColor.color1
    
    @Published var isPresentCreate = false
    @Published var isPresentEdit = false
    
    @Published var simpleTaskText = ""
    
    @Published var simpleTasks: [String] = []
    @Published var countTask = 0
    
    @Published var simpleDegrees: Double = 0
    @Published var wheelWinNumber = 1
    
    init(){
        getSpins()
        getTasks()
        if isFirstSpin ?? true {
            addPreviewData(game: "Fun tasks", tasks: [" Tell a funny joke!","Make a crooked face at the camera.", "Sing the first lines of a famous", "Read the tongue twister.","Draw an animal while the others guess.","Come up with a new slogan for the party.","Shout Cake! to the whole room.","Make spiders on each something that you find.","Persuade your neighbor to do something unimaginable.","Come up with and show a new dance (at least 15 seconds)."])
            isFirstSpin = false
        }
    }
    
    //MARK: - Spining wheel
    func spining(){
        if simpleDegrees != 0{
            simpleDegrees = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: DispatchWorkItem(block: { [self] in
                simpleDegrees = Double.random(in: 360...720)
            }))
        }else {
            simpleDegrees = Double.random(in: 360...720)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: DispatchWorkItem(block: { [self] in
            getWheelWinNumber()
        }))
    }
    
    func getWheelWinNumber(){
        let position = simpleDegrees - 360
        switch position {
        case 325...346 :  wheelWinNumber = 2
        case 12...34 :   wheelWinNumber = 16
        case 34...56 :  wheelWinNumber = 15
        case 56...79 :  wheelWinNumber = 14
        case 79...103 :  wheelWinNumber = 13
        case 103...125 :  wheelWinNumber = 12
        case 125...149 :  wheelWinNumber = 11
        case 149...169 :  wheelWinNumber = 10
        case 169...192 :   wheelWinNumber = 9
        case 192...213 :  wheelWinNumber = 8
        case 213...236 :  wheelWinNumber = 7
        case 236...259 :  wheelWinNumber = 6
        case 259...280 :  wheelWinNumber = 5
        case 280...302 :  wheelWinNumber = 4
        case 302...325 :  wheelWinNumber = 3
        default:
            wheelWinNumber = 1
        }
    }
    
    
    func getTaskAfterSpin(spin: SpinFortune){
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: DispatchWorkItem(block: { [self] in
            if let tasks = spin.task?.allObjects as? [Task]{
                if wheelWinNumber <= tasks.count{
                    simpleTaskText = tasks[wheelWinNumber].textTask ?? ""
                }else {
                    simpleTaskText = tasks.randomElement()?.textTask ?? ""
                }
            }
        }))
        
        
    }
    
    //MARK: - Fill data checklist
    func fillData(spin: SpinFortune){
        simpleNameGame = spin.nameGame ?? ""
        simpleTasks = []
        
        if let tasks = spin.task?.allObjects as? [Task]{
            for task in tasks {
                simpleTasks.append(task.textTask ?? "")
            }
            countTask = tasks.count
        }
    }
    
    //MARK: - Edit data
    func editSpinFortune(spin: SpinFortune){
        let request = NSFetchRequest<SpinFortune>(entityName: "SpinFortune")
        do{
            spinsFortune = try manager.context.fetch(request)
            let spin = spinsFortune.first(where: {$0.id == spin.id})
            spin?.nameGame = simpleNameGame
            if let tasks = spin?.task?.allObjects as? [Task]{
                for task in tasks {
                    manager.context.delete(task)
                }
            }
            for simpleTask in simpleTasks {
                addOneTask(task: simpleTask, spin: spin!)
            }
        }catch let error{
            print("Error fetch checkList: \(error.localizedDescription)")
        }
        saveSpin()
        saveTask()
        clear()
    }
    
    //MARK: - Delete data
    func deleteSpinList(spin: SpinFortune){
        if let tasks = spin.task?.allObjects as? [Task]{
            for task in tasks {
                manager.context.delete(task)
            }
           saveTask()
        }
        manager.context.delete(spin)
        saveSpin()
    }
    
    //MARK: -   AddOneMoreTaskCell
    func addCelltask(){
            simpleTasks.append(simpleTaskText)
            countTask += 1
    }
    
    //MARK: - Add data
    func addSpin(){
        let newSpin = SpinFortune(context: manager.context)
        newSpin.backGround = simpleBackGround
        newSpin.nameGame = simpleNameGame
        newSpin.wheelColor = UIImage(resource: simpleColor.Wheel)
        newSpin.spin = UIImage(resource: simpleColor.spin)
        newSpin.color = UIImage(resource: simpleColor.spinColor)

        
        for simpleTask in simpleTasks {
            addOneTask(task: simpleTask, spin: newSpin)
        }
        saveSpin()
        clear()
        
    }
    func addOneTask(task: String, spin: SpinFortune){
        let newtask = Task(context: manager.context)
        newtask.textTask = task
        newtask.compltd = false
        newtask.spinFortune = spin
        saveTask()
    }
    
    func addPreviewData(game: String, tasks: [String]){
        let newSpin = SpinFortune(context: manager.context)
        newSpin.backGround = simpleBackGround
        newSpin.nameGame = game
        newSpin.wheelColor = UIImage(resource: simpleColor.Wheel)
        newSpin.spin = UIImage(resource: simpleColor.spin)
        newSpin.color = UIImage(resource: simpleColor.spinColor)
        
        for task in tasks {
            addOneTask(task: task, spin: newSpin)
        }
        saveSpin()
        clear()
        
    }
    
    //MARK: - Get data
    func getSpins(){
        let request = NSFetchRequest<SpinFortune>(entityName: "SpinFortune")
        do{
            spinsFortune = try manager.context.fetch(request)
        }catch let error{
            print("Error fetch Games: \(error.localizedDescription)")
        }
    }
    private func getTasks(){
        let request = NSFetchRequest<Task>(entityName: "Task")
        do{
            tasks = try manager.context.fetch(request)
        }catch let error{
            print("Error fetch tasks: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Save data
    func saveSpin(){
        spinsFortune.removeAll()
        manager.save()
        getSpins()
    }
    private func saveTask(){
        tasks.removeAll()
        manager.save()
        getTasks()
    }
    
    //MARK: - Clear data
    func clear(){
        simpleTasks = []
        countTask = 0
        simpleTaskText = ""
        simpleNameGame = ""
        simpleBackGround = UIImage(resource: .noSpinBack)
        simpleColor = SpinColor.color1
    }
}
