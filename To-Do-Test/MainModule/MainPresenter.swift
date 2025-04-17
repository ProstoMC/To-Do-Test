//
//  MainPresenter.swift
//  To-Do-Test
//
//  Created by admin on 03.04.25.
//

import Foundation


protocol MainPresenterProtocol: AnyObject {
    func fetchData()
    func didFetchTasks(_ tasks: [ToDo])
   
    func deleteTask(index: Int)
    //func didSelectItem(at index: Int)
    
    
    //MARK: - Fault funcs
    func didFailWithTasks(errorMessage: String)
    func didFailWithDelete(errorMessage: String, tasks: [ToDo])
}

class MainPresenter: MainPresenterProtocol {

    
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol
    var router: MainRouterProtocol
    
    init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Tasks from VC
    
    func fetchData() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [self] in
            interactor.createTaskList()
        }
    }
    
    func deleteTask(index: Int) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { [self] in
            interactor.deleteTask(index: index)
        }
    }
    
    
    //MARK: - Tasks from Interactor
    func didFetchTasks(_ tasks: [ToDo]) {
        let cells = convertToDoListForCellDataList(tasks)
        
        let bottomInfoText = String(localized: "\(tasks.count) tasks")
        
        //Push ViewModule to VC
        DispatchQueue.main.async { [self] in
            view?.updateView(MainViewModel(bottomInfoText: bottomInfoText, items: cells))
        }
    }
    
    
    
    func didFailWithTasks(errorMessage: String) {
        DispatchQueue.main.async { [self] in
            view?.updateView(MainViewModel(bottomInfoText: errorMessage, items: []))
        }
    }
    
    
    //MARK: - Fault funcs
    func didFailWithDelete(errorMessage: String, tasks: [ToDo]) {
        let cells = convertToDoListForCellDataList(tasks)
        DispatchQueue.main.async { [self] in
            view?.updateView(MainViewModel(bottomInfoText: errorMessage, items: cells))
        }
    }
    

    
//    func didSelectItem(at index: Int) {
//        router.navigateToDetail(with: "Item \(index + 1)")
//    }
}
//MARK: - Internal funcs
extension MainPresenter {
    private func convertToDoListForCellDataList(_ toDoList: [ToDo]) -> [MainCellContent] {
        var cells: [MainCellContent] = []
        
        let formatter = DateFormatter()

        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        
        //Converting entity for viewModel
        toDoList.forEach({ task in
            //Preparing date
            var date = String(localized: "No date")
            if task.date != nil {
                date = formatter.string(from: task.date!)
            }
            
            cells.append(MainCellContent(
                title: task.title ?? "Task not found",
                body: task.body ?? "",
                isDone: task.isDone,
                date: date
            ))
        })
        return cells
    }
}
