//
//  MainTabController.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 20/07/21.
//

import UIKit

// MARK: - MainTabController Class
final class MainTabBarController: UITabBarController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
    }
    
    // MARK: - Helpers
    private func checkIfUserIsLoggedIn() {
        if !UserService.shared.isUserLoggedIn {
            DispatchQueue.main.async {
                let loginController = LoginController()
                loginController.delegate = self
                let navigationController = UINavigationController(rootViewController: loginController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
        }
    }
    
    private func configureViewControllers() {
        view.backgroundColor = .white
        UITabBar.appearance().tintColor = Constants.primaryColor
        let remindersViewController = createNavigationController(unselectedImage: UIImage(named: "bell")!, selectedImage: UIImage(named: "bell.fill")!, titleItem: "Recordatorios", rootViewController: RemindersController())
        let evaluationViewController = createNavigationController(unselectedImage: UIImage(named: "wallet.pass")!, selectedImage: UIImage(named: "wallet.pass.fill")!, titleItem: Constants.evaluationTitle, rootViewController: EvaluationController())
        let progressViewController = createNavigationController(unselectedImage: UIImage(named: "person")!, selectedImage: UIImage(named: "person.fill")!, titleItem: "Mi progreso", rootViewController: ProgressController())
        
        viewControllers = [remindersViewController, evaluationViewController, progressViewController]
        selectedIndex = 1 // Attribute of an UITabBarController, specifies the initial ViewController
    }
    
    private func createNavigationController(unselectedImage: UIImage, selectedImage: UIImage, titleItem: String, rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = titleItem
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        
        return navigationController
    }
}

extension MainTabBarController: AuthenticationDelegate {
    func authenticationDidComplete(user: User) {
        UserService.shared.saveToken(token: user.token)
        configureViewControllers()
        self.dismiss(animated: true, completion: nil)
    }
}
