//
//  MainInteractor.swift
//  To-Do-Test
//
//  Created by admin on 03.04.25.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func createTaskList()
    func deleteTask(index: Int)
}

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?
    var fetcher: Fetcher!
    var coreDataManager: CoreDataManager!
    
    private var toDoList: [ToDo] = []
    
    func createTaskList() {
        
        if isFirstLaunch() {
            fetchDataFromEth(completion: { [self] result in
                if !result {
                    presenter?.didFailWithTasks(errorMessage: "Internet error")
                    return
                }
                
                let toDoList = coreDataManager.fetchToDoList()
                print (toDoList.count)
                presenter?.didFetchTasks(toDoList)
            })
        }
        
        else {
            toDoList = coreDataManager.fetchToDoList()
            print (toDoList.count)
            presenter?.didFetchTasks(toDoList)
        }
    }
    
    private func fetchDataFromEth(completion: @escaping (Bool) -> Void) {
        
        //JSON Struct for parsing
        struct JsonData: Codable {
            var todos: [Todos]
        }
        struct Todos: Codable {
            var id: Int
            var todo: String
            var completed: Bool
            var userId: Int //Not used
        }
        //Start fetching after eth
        fetcher.fetchData(completion: { [self] data in
            //Check is there data
            guard let data = data else {
                completion(false)
                return
            }
            //Convert data to CoreData and save
            do {
                let json = try JSONDecoder().decode(JsonData.self, from: data)
                //Saving each todo
                json.todos.forEach { todo in
                    _ = coreDataManager.createTask(
                        title: todo.todo,
                        body: "",
                        date: nil,
                        isDone: todo.completed)
                }
                completion(true)
            } catch {
                print(error)
                completion(false)
            }
            
        })
    }
    
    
    //MARK: - Delete task
    func deleteTask(index: Int) {
        if coreDataManager.deleteTask(toDo: toDoList[index]) {
            createTaskList()
        }
        else {
            presenter?.didFailWithDelete(errorMessage: "Deleting task error", tasks: toDoList)
        }
    }
    
    
}

//MARK: - Internal funcs
extension MainInteractor {
    private func isFirstLaunch() -> Bool {
        let hasLaunchedKey = "hasLaunchedBefore"
        let userDefaults = UserDefaults.standard

        if userDefaults.bool(forKey: hasLaunchedKey) {
            return false
        } else {
            userDefaults.set(true, forKey: hasLaunchedKey)
            return true
        }
    }
}
