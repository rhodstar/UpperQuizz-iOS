//
//  LoginController.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 11/09/21.
//

import UIKit

protocol AuthenticationDelegate: AnyObject {
    func authenticationDidComplete()
}

final class LoginController: UIViewController {
    // MARK: - Properties
    private weak var emailTextField: UITextField?
    private weak var passwordTextField: UITextField?
    private weak var loginButton: UIButton?
    private weak var registerButtonNavigation: UIButton?
    weak var delegate: AuthenticationDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    @objc func handleShowSignUp() {
        let registrationController = RegistrationController()
        registrationController.delegate = delegate
        navigationController?.pushViewController(registrationController, animated: true)
    }
    
    // MARK: - Helper functions
    func configureUI() {
        view.backgroundColor = Constants.primaryColor
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        let emailTextField = UQTextField(placeholder: "Email")
        emailTextField.keyboardType = .emailAddress
        self.emailTextField = emailTextField
        
        let passwordTextField = UQTextField(placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
        self.passwordTextField = passwordTextField
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.3501588404, green: 0.4323381186, blue: 0.6990520358, alpha: 1).withAlphaComponent(0.5)
        loginButton.layer.cornerRadius = 5
        loginButton.setHeight(50)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.isEnabled = false
        //loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        let registerButtonNavigation = UIButton(type: .system)
        registerButtonNavigation.attributedTitle(firstPart: "¿No tienes una cuenta? ", secondPart: "Regístrate")
        registerButtonNavigation.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        self.registerButtonNavigation = registerButtonNavigation
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, registerButtonNavigation])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
