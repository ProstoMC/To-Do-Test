
//
//  CoreDataWorker.swift
//  To-Do-Test
//
//  Created by admin on 04.04.25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchToDoList() -> [ToDo] {
        var toDoList: [ToDo] = []
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do {
            toDoList = try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return toDoList
    }
    
    func saveChanges() -> Bool {
        do {
            try context.save()
            return true
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    func createTask(title: String, body: String?, date: Date?, isDone: Bool) -> ToDo? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "ToDo", in: context) else { return nil }
        let toDo = NSManagedObject(entity: entityDescription, insertInto: context) as! ToDo
        
        toDo.title = title
        toDo.body = body
        toDo.date = date
        toDo.isDone = isDone
        
        if saveChanges() {
            return toDo
        } else {
            return nil
        }
    }
    
    func changeTaskStatus(toDo: ToDo) -> Bool {
        toDo.isDone.toggle()
        if saveChanges() { return true }
        else { return false }
    }
    
    func deleteTask(toDo: ToDo) -> Bool {
        context.delete(toDo)
        if saveChanges() {
            return true
        } else {
            return false
        }
    }
}
