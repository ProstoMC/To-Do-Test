//
//  MainViewModel.swift
//  To-Do-Test
//
//  Created by admin on 03.04.25.
//

import Foundation


struct MainCellContent {
    var title: String
    var body: String
    var isDone: Bool
    var date: String
}

struct MainViewModel {
    var bottomInfoText: String
    var items: [MainCellContent]
}
