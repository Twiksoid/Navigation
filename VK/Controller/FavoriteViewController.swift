//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 18.11.2022.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    var searchController = UISearchController(searchResultsController: nil)
    
    var coreDataManager = CoreDataManager()
    var foundPosts: [Posts] {
        get { return coreDataManager.posts }
        set { coreDataManager.posts = newValue
            print("Setter") }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString(LocalizedKeys.keyPullToRefreshText, comment: ""))
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        foundPosts = coreDataManager.posts
        coreDataManager.reloadData()
        tableView.reloadData()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        coreDataManager.reloadData()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func setupView(){
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = NSLocalizedString(LocalizedKeys.keyViewFavoriteTitle, comment: "")
        view.addSubview(tableView)
        
        // настройка Constrait
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foundPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostTableViewCell {
            cell.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
            if let idForPost = foundPosts[indexPath.row].id {
                cell.setupForFavoriteFromCoreData(for: idForPost)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = foundPosts[indexPath.row]
            coreDataManager.deletePostTypeNote(post: post)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            coreDataManager.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        foundPosts = coreDataManager.getPostsBy(author: searchController.searchBar.text ?? "")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FavoriteViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        foundPosts = coreDataManager.getPostsBy(author: searchController.searchBar.text ?? "")
        tableView.reloadData()
    }
    
}
