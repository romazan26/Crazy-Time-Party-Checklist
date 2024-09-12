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
    
    init(){
        getSpins()
        getTasks()
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
        newSpin.tag = Int16(spinsFortune.count + 1)
        
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
