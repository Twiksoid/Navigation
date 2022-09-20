//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Nikita Byzov on 05.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: FeedViewController())
        let secondItemController = UINavigationController(rootViewController: LogInViewController())
        let secondVC = LogInViewController()
        secondVC.loginDelegate = LoginInspector()
        let secondVCForShowing = UINavigationController(rootViewController: secondVC)
        //navigationController.pushViewController(secondVC, animated: true)
        // _ = UINavigationController(rootViewController: ProfileViewController())
        _ = UINavigationController(rootViewController: PhotosViewController())
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            navigationController,
            //secondItemController,
            //secondVC,
            secondVCForShowing
        ]
        // задаем цвет для navigationController (верх) и tabBarController (низ)
        navigationController.navigationBar.backgroundColor = UIColor.white
        secondItemController.navigationBar.backgroundColor = UIColor.white
        tabBarController.tabBar.backgroundColor = UIColor.white
        tabBarController.viewControllers?[0].tabBarItem.title = "Лента"
        tabBarController.viewControllers?[1].tabBarItem.title = "Профиль"
        
        tabBarController.viewControllers?.enumerated().forEach {
            $1.tabBarItem.image = $0 == 0 ? UIImage(systemName: "paperplane.fill")
            : UIImage(systemName: "brain.head.profile")
        }
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
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
