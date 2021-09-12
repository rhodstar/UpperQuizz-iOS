//
//  RegistrationController.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 11/09/21.
//

import UIKit

final class RegistrationController: UIViewController {
    // MARK: - Properties
    private weak var usernameTextField: UITextField?
    private weak var lastnameTextField: UITextField?
    private weak var emailTextField: UITextField?
    private weak var passwordTextField: UITextField?
    private weak var signUpButton: UIButton?
    private weak var loginButtonNavigation: UIButton?
    weak var delegate: AuthenticationDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setHidesBackButton(true, animated: false)
        title = "Crea tu cuenta"
    }
    
    // MARK: - Actions
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper functions
    private func configureUI() {
        view.backgroundColor = Constants.primaryColor
        let usernameTextField = UQTextField(placeholder: "Nombre")
        self.usernameTextField = usernameTextField
        let lastnameTextField = UQTextField(placeholder: "Apellidos")
        self.lastnameTextField = lastnameTextField
        let emailTextField = UQTextField(placeholder: "Email")
        emailTextField.keyboardType = .emailAddress
        self.emailTextField = emailTextField
        let passwordTextField = UQTextField(placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
        self.passwordTextField = passwordTextField
        
        let signUpButton = UIButton()
        signUpButton.setTitle("Regístrate", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        signUpButton.layer.cornerRadius = 5
        signUpButton.setHeight(50)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpButton.isEnabled = false
        // signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        self.signUpButton = signUpButton
        
        let loginButtonNavigation = UIButton()
        loginButtonNavigation.attributedTitle(firstPart: "¿Ya tienes una cuenta?", secondPart: "Inicia sesión")
        loginButtonNavigation.contentHorizontalAlignment = .leading
        loginButtonNavigation.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        self.loginButtonNavigation = loginButtonNavigation
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, lastnameTextField, emailTextField, passwordTextField, signUpButton, loginButtonNavigation])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
