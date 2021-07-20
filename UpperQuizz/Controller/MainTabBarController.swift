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
        configureViewControllers()
    }
    
    // MARK: - Helpers
    private func configureViewControllers() {
        view.backgroundColor = .white
        let remindersViewController = RemindersController()
        let testsViewController = TestsController()
        let progressViewController = ProgressController()
        
        viewControllers = [remindersViewController, testsViewController, progressViewController]
    }
}
