//
//  ViewController.swift
//  To-Do-Test
//
//  Created by admin on 31.03.25.
//

import UIKit




protocol MainViewProtocol: AnyObject {
    func updateView(_ viewModel: MainViewModel)
}


class MainViewController: UIViewController, UISearchResultsUpdating {
    var presenter: MainPresenterProtocol!
    
    var cells: [MainCellContent] = []
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var tableView = UITableView()
    private var bottomView = UIView()
    private var bottomLabel = UILabel()
    private var newTaskButton = UIButton()
    private var infoButton = UIButton()
    private var blurView: UIVisualEffectView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainVC loaded")
        setupUI()
        presenter.fetchData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    
    @objc func infoButtonTapped() {
        return
    }
    
}

extension MainViewController: MainViewProtocol {
    func updateView(_ viewModel: MainViewModel) {
        cells = viewModel.items
        bottomLabel.text = viewModel.bottomInfoText
        tableView.reloadData()
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
        navigationItem.largeTitleDisplayMode = .automatic
        
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
    
    private func setupBottomBlock() {
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
        
        bottomLabel.text = String(localized: "\(cells.count) tasks")
        
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
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .additionalGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.tableHeaderView = UIView() //Hide top separator
        tableView.backgroundColor = .background
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }
    

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        cell.selectionStyle = .none
        
        
        cell.configure(
            title: cells[indexPath.row].title,
            subtitle: cells[indexPath.row].body,
            date: cells[indexPath.row].date,
            isDone: cells[indexPath.row].isDone
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

        return UIContextMenuConfiguration(identifier: nil, previewProvider: { [self] in
            
            let blurView = BlurView()
            blurView.configure(with: cells[indexPath.row])
            return blurView
        }, actionProvider: { _ in
            
            let edit = UIAction(title: String(localized: "Edit"), image: UIImage(systemName: "square.and.pencil")) { _ in
                return
            }
            let share = UIAction(title: String(localized: "Share"), image: UIImage(systemName: "square.and.arrow.up")) { _ in
                return
            }
            let delete = UIAction(title: String(localized: "Delete"), image: UIImage(systemName: "trash"), attributes: .destructive) { [self] _ in
                presenter.deleteTask(index: indexPath.row)
            }
            return UIMenu(title: "", children: [edit, share, delete])
        })
    }
    
    
}
