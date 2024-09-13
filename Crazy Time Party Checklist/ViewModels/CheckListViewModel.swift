//
//  CheckListViewModel.swift
//  Crazy Time Party Checklist
//
//  Created by Роман on 11.09.2024.
//

import Foundation
import CoreData

final class CheckListViewModel: ObservableObject{
    
    let manager = CoreDataManager.instance
    
    @Published var checkLists: [CheckList] = []
    @Published var tasks: [Task] = []
    
    @Published var simpleCheckListName = ""
    @Published var simpleTaskText = ""
    
    @Published var simpleTasks: [String] = []
    @Published var countTask = 0
    
    @Published var isPresentAddCheckList = false
    @Published var isPresentEditCheckList = false
    
    init(){
        getCheckLists()
        getCheckLists()
    }
    
    //MARK: - share function
    func shareTasks(checkList: CheckList) -> String{
        var sharetext = ""
        if let tasks = checkList.task?.allObjects as? [Task]{
            for task in tasks {
                sharetext.append(" \(task.textTask ?? "")")
            }
        }else {
            sharetext = "no tasks for checkList"
        }
        return sharetext
    }
    
    //MARK: - Fill data checklist
    func fillData(checkList: CheckList){
        simpleCheckListName = checkList.nameList ?? ""
        simpleTasks = []
        
        if let tasks = checkList.task?.allObjects as? [Task]{
            for task in tasks {
                simpleTasks.append(task.textTask ?? "")
            }
            countTask = tasks.count
        }
    }
    
    //MARK: - Get count comleted task
    func getCountComplt(tasks: [Task]) -> Int{
        var count = 0
        for task in tasks {
            if task.compltd{
                count += 1
            }
        }
        return count
    }
    
    //MARK: -   AddOneMoreTaskCell
    func addCelltask(){
            simpleTasks.append(simpleTaskText)
            countTask += 1
    }
    
    //MARK: - Delete data
    func deleteCheckList(checkList: CheckList){
        if let tasks = checkList.task?.allObjects as? [Task]{
            for task in tasks {
                manager.context.delete(task)
            }
           saveTask()
        }
        manager.context.delete(checkList)
        saveCheckList()
    }
    
    //MARK: - Edit data
    func comletedTask(task: Task){
        let request = NSFetchRequest<Task>(entityName: "Task")
        do{
            tasks = try manager.context.fetch(request)
            let task = tasks.first(where: {$0.id == task.id})
            task?.compltd.toggle()
        }catch let error{
            print("Error fetch tasks: \(error.localizedDescription)")
        }
        saveTask()
    }
    
    func editCheckList(checkList: CheckList){
        let request = NSFetchRequest<CheckList>(entityName: "CheckList")
        do{
            checkLists = try manager.context.fetch(request)
            let checkList = checkLists.first(where: {$0.id == checkList.id})
            checkList?.nameList = simpleCheckListName
            if let tasks = checkList?.task?.allObjects as? [Task]{
                for task in tasks {
                    manager.context.delete(task)
                }
            }
            for simpleTask in simpleTasks {
                addOneTask(task: simpleTask, checkList: checkList!)
            }
        }catch let error{
            print("Error fetch checkList: \(error.localizedDescription)")
        }
        saveCheckList()
        saveTask()
        clear()
    }
    
    //MARK: - Add data
    func addCheckList(){
        let newCheckList = CheckList(context: manager.context)
        newCheckList.nameList = simpleCheckListName
        for simpleTask in simpleTasks {
            addOneTask(task: simpleTask, checkList: newCheckList)
        }
        saveCheckList()
        saveTask()
        clear()
    }
    
    func addOneTask(task: String, checkList: CheckList){
        let newtask = Task(context: manager.context)
        newtask.textTask = task
        newtask.compltd = false
        newtask.cheklist = checkList
        saveTask()
    }
    
    //MARK: - Get data
    private func getCheckLists(){
        let request = NSFetchRequest<CheckList>(entityName: "CheckList")
        do{
            checkLists = try manager.context.fetch(request)
        }catch let error{
            print("Error fetch checkList: \(error.localizedDescription)")
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
    private func saveCheckList(){
        checkLists.removeAll()
        manager.save()
        getCheckLists()
    }
    
    private func saveTask(){
        tasks.removeAll()
        manager.save()
        getTasks()
    }
    
    //MARK: - Clear data
    func clear(){
        simpleTasks = []
        simpleTaskText = ""
        simpleCheckListName = ""
    }
}
