//
//  ViewController.swift
//  To-Do-Test
//
//  Created by admin on 31.03.25.
//

import UIKit

struct CellContent {
    var title: String
    var body: String
    var isDone: Bool
    var date: String
}

class MainViewController: UIViewController, UISearchResultsUpdating {
    
    
    var cellsData: [CellContent] = [
        CellContent(title: "First", body: "First body", isDone: true, date: "12.12.2025"),
        CellContent(title: "Second", body: "Second bodyp;dkdfldjsf;laksfkskf;laskf;lasf;las;lfkas;lfkas;lfkas;lfa;lskf;a", isDone: false, date: "01.02.2025")
    ]
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var tableView = UITableView()
    private var bottomLabel = UILabel()
    private var newTaskButton = UIButton()
    private var infoButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    
    @objc func infoButtonTapped() {
        return
    }

    
}

extension MainViewController {
    private func setupUI() {
        view.backgroundColor = .background
        
        setupNavigationBar()
        setupSearchController()
        setupTableView()
        setupBottomBlock()
        
    }
    private func setupNavigationBar() {
        self.title = String(localized: "Tasks")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .background
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.tintColor = .elements
        searchController.searchBar.searchTextField.textColor = .white
        
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.tableHeaderView = UIView() //Hide top separator
        tableView.backgroundColor = .background
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBottomBlock() {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        bottomView.backgroundColor = .additionalGray
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        newTaskButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(newTaskButton)
        
        newTaskButton.tintColor = .elements
        newTaskButton.clipsToBounds = true
        newTaskButton.contentMode = .scaleAspectFit
        newTaskButton.setBackgroundImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        
        NSLayoutConstraint.activate([
            newTaskButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -20),
            newTaskButton.heightAnchor.constraint(equalToConstant: 30),
            newTaskButton.widthAnchor.constraint(equalToConstant: 30),
            newTaskButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10)
        ])
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(bottomLabel)
        bottomLabel.textColor = .white
        bottomLabel.backgroundColor = .additionalGray
        bottomLabel.textAlignment = .center
        bottomLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        NSLayoutConstraint.activate([
            bottomLabel.centerYAnchor.constraint(equalTo: newTaskButton.centerYAnchor),
            bottomLabel.heightAnchor.constraint(equalToConstant: 15),
            bottomLabel.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.7),
            bottomLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
        ])
        
        bottomLabel.text = String(localized: "\(cellsData.count) tasks")
        
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(infoButton)
        
        infoButton.tintColor = .elements.withAlphaComponent(0.9)
        infoButton.clipsToBounds = true
        infoButton.contentMode = .scaleAspectFit
        infoButton.setBackgroundImage(UIImage(systemName: "info.circle"), for: .normal)
        
        NSLayoutConstraint.activate([
            infoButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 20),
            infoButton.heightAnchor.constraint(equalToConstant: 30),
            infoButton.widthAnchor.constraint(equalToConstant: 30),
            infoButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10)
        ])
        
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        
        cell.configure(
            title: cellsData[indexPath.row].title,
            subtitle: cellsData[indexPath.row].body,
            date: cellsData[indexPath.row].date,
            isDone: cellsData[indexPath.row].isDone
        )
        
        //Hide bottom separator
        if indexPath.row == cellsData.count-1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        
        return cell
    }
    
    
}
