//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Nikita Byzov on 05.07.2022.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: FeedViewController())
        let secondItemController = UINavigationController(rootViewController: LogInViewController())
        //let thirdItemController = UINavigationController(rootViewController: InfoViewController())
        let forthItemController = UINavigationController(rootViewController: FavoriteViewController())
        //let fifthItemController = UINavigationController(rootViewController: MapViewController())
        // обозначаем второй экран (форма входа)
        // создаем объект фабрики
        // вызываем метод создания объекта типа LoginInspector
        // присваиваем этот результат делегату
        // передаем для создания нав контроллера
        let secondVC = LogInViewController()
        let loginInspectorCreaterByFabric = MyLoginFactory()
        secondVC.loginDelegate = loginInspectorCreaterByFabric.makeLoginInspector()
        let secondVCForShowing = UINavigationController(rootViewController: secondVC)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            navigationController,
            secondVCForShowing,
            // thirdItemController,
            forthItemController
            //, fifthItemController
        ]
        // задаем цвет для navigationController (верх) и tabBarController (низ)
        navigationController.navigationBar.backgroundColor = UIColor.white
        secondItemController.navigationBar.backgroundColor = UIColor.white
        tabBarController.tabBar.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        tabBarController.viewControllers?[0].tabBarItem.title = NSLocalizedString(LocalizedKeys.keyFeed, comment: "")
        tabBarController.viewControllers?[1].tabBarItem.title = NSLocalizedString(LocalizedKeys.keyProfile, comment: "")
        // tabBarController.viewControllers?[2].tabBarItem.title = NSLocalizedString(LocalizitedKeys.keyInfo, comment: "")
        tabBarController.viewControllers?[2].tabBarItem.title = NSLocalizedString(LocalizedKeys.keyFavorite, comment: "")
        //tabBarController.viewControllers?[4].tabBarItem.title = NSLocalizedString(LocalizitedKeys.keyMap, comment: "")
        //
        //        tabBarController.viewControllers?.enumerated().forEach {
        //
        //            $1.tabBarItem.image = $0 == 0 ? UIImage(systemName: "paperplane.fill")
        //            : UIImage(systemName: "brain.head.profile")
        //        }
        
        tabBarController.tabBar.items?[0].image = UIImage(systemName: "paperplane.fill")
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "brain.head.profile")
        //tabBarController.tabBar.items?[2].image = UIImage(systemName: "info.circle")
        tabBarController.tabBar.items?[2].image = UIImage(systemName: "bookmark.fill")
        //tabBarController.tabBar.items?[4].image = UIImage(systemName: "map")
        
        
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        // путь папки на устройстве -
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        
        
        // Создаем рандомную ссылку для обращения к API
        //let randomValueForApi = AppConfiguration.allCases.randomElement()!
        //print("Ссылка, которую сформировали рандомно - ", randomValueForApi.rawValue)
        
        // Передаем ссылку в сервис для обращения к API, задача 1 , Домашнее задание 1
        //NetworkService.request(for: randomValueForApi)
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        try? Auth.auth().signOut()
        print("Scene disconnected")
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        if Auth.auth().currentUser == nil {
            print("User isn't login")
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}
