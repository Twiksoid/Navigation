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
        let secondItemController = UINavigationController(rootViewController: LogInViewController())
        let forthItemController = UINavigationController(rootViewController: FavoriteViewController())
        
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
            secondVCForShowing,
            forthItemController
        ]
        // задаем цвет для navigationController (верх) и tabBarController (низ)
        secondItemController.navigationBar.backgroundColor = UIColor.white
        tabBarController.tabBar.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)

        tabBarController.viewControllers?[0].tabBarItem.title = NSLocalizedString(LocalizedKeys.keyProfile, comment: "")
        tabBarController.viewControllers?[1].tabBarItem.title = NSLocalizedString(LocalizedKeys.keyFavorite, comment: "")

        tabBarController.tabBar.items?[0].image = UIImage(systemName: "brain.head.profile")
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "bookmark.fill")
        
        
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        // путь папки на устройстве -
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        
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
