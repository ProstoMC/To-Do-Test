//
//  Router.swift
//  To-Do-Test
//
//  Created by admin on 03.04.25.
//

import Foundation
import UIKit

protocol MainRouterProtocol {
    //func navigateToDetail(with title: String)
}

class MainRouter: MainRouterProtocol {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.fetcher = Fetcher()
        interactor.coreDataManager = CoreDataManager()
        
        return view
    }
    
//    func navigateToDetail(with title: String) {
//        let detailVC = DetailViewController()
//        detailVC.itemTitle = title
//        viewController?.navigationController?.pushViewController(detailVC, animated: true)
//    }
}
