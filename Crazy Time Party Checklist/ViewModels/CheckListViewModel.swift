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
    
    init(){
        getCheckLists()
        getCheckLists()
    }
    
    //MARK: -   AddOneMoreTaskCell
    func addCelltask(){
            simpleTasks.append(simpleTaskText)
            countTask += 1
    }
    
    //MARK: - Add data
    func addCheckList(){
        let newCheckList = CheckList(context: manager.context)
        newCheckList.nameList = simpleCheckListName
        saveCheckList()
        simpleCheckListName = ""
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
}
