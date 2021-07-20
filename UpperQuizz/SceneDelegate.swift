//
//  SceneDelegate.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 20/07/21.
//

import UIKit

// MARK: - SceneDelegate Class
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - UIWindowsSceneDelegate methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
}
