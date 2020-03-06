//
//  SceneDelegate.swift
//  OnrampProject
//
//  Created by Giovanni Noa on 2/20/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         CoreDataManager.setUpCoreDataStack()

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let photoListVC = PhotoListViewController()
        let favoritePhotosVC = FavoritePhotosViewController()
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([photoListVC, favoritePhotosVC], animated: true)
        photoListVC.tabBarItem = UITabBarItem(title: "Photos", image: UIImage(systemName: "list.dash"), selectedImage: UIImage(systemName: "list.dash"))
        favoritePhotosVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart"))

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        try? CoreDataManager.shared.context.save()
    }

}
