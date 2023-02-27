//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 12.07.2022.
//

import UIKit
import FirebaseAuth

var handle: AuthStateDidChangeListenerHandle?

class ProfileViewController: UIViewController {
    
    let user: User?
    
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "miniCollectionView")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Тут лежат посты для ленты
    private var viewModel: [Post] = [
        post0,
        post1,
        post2,
        post3,
        post4,
        post5
    ]
    
    // тут лежат фото для миниатюры
    private var photoModel: [String] = [
        "1.jpg",
        "2.jpg",
        "3.jpg",
        "4.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // настраиваем базовые вью
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Начинаем слушать авторизацию пользователя
        // если ее нет, то выкинем алерт
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                let alarm = UIAlertController(title: NSLocalizedString(LocalizedKeys.keyNotLoginUserTitleAlarm, comment: ""),
                                              message: NSLocalizedString(LocalizedKeys.keyNotLoginUserTextAlarm, comment: ""),
                                              preferredStyle: .alert)
                let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizedKeys.keyNotLoginUserAction, comment: ""),
                                                style: .default)
                alarm.addAction(alarmAction)
                self.present(alarm, animated: true)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func setupView(){
        // чтобы закрасить основное вью
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        // чтобы большим было
        // navigationController?.navigationBar.prefersLargeTitles = true
        // чтобы автоматом подбирало размер
        
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = NSLocalizedString(LocalizedKeys.keyViewTitle, comment: "")
        view.addSubview(tableView)
        
        // настройка Constrait
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo:self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func goToCollection(for index: IndexPath){
        let vcCollection = PhotosViewController()
        self.navigationController?.pushViewController(vcCollection, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileHeaderView {
                // передача ссылки на вью, с которого уходим
                  headerView.delegateExit = self
                // настроим, кого выводить
                headerView.setupHeader(for: user)
                return headerView
            } else {
                return nil
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // добавляю мини фотки
        if indexPath.section == 0 && indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "miniCollectionView", for: indexPath) as? PhotosTableViewCell {
                cell.selectionStyle = .none
                cell.setupMiniCollection(for: photoModel)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
        } else {
            // добавляю посты
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? PostTableViewCell {
                let post = self.viewModel[indexPath.row]
                cell.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
                cell.setup(for: post)
                cell.index = indexPath
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                cell.textLabel?.text = NSLocalizedString(LocalizedKeys.keyPullToRefreshText, comment: "")
                return cell
            }
        }}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            goToCollection(for: indexPath)
        }
    }
    
    func showAlertRestartApp(){
        let alert = UIAlertController(title: NSLocalizedString(LocalizedKeys.keyRestartYourApp, comment: ""),
                                      message: NSLocalizedString(LocalizedKeys.keyRestartYourAppText, comment: ""),
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString(LocalizedKeys.keyTimeAlertOk, comment: ""),
                                        style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}


