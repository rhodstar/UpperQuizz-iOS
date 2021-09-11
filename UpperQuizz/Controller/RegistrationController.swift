//
//  RegistrationController.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 11/09/21.
//

import UIKit

final class RegistrationController: UIViewController {
    // MARK: - Lifecycle
    weak var delegate: AuthenticationDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.primaryColor
    }
}
