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
    private var viewModel = RegistrationViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
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
    
    @objc func handleSignUp() {
        guard let username = usernameTextField?.text else { return }
        guard let lastname = lastnameTextField?.text else { return }
        guard let email = emailTextField?.text else { return }
        guard let password = self.passwordTextField?.text else { return }
        
        let credentials = RegisterCredentials(nombre: username, apellidos: lastname, correo: email, contrasena: password)
        
        AuthenticationService.shared.registerUser(with: credentials) { message in
            print(message)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if(sender == passwordTextField) {
            viewModel.password = sender.text
        } else if(sender == usernameTextField) {
            viewModel.username = sender.text
        } else {
            viewModel.lastname = sender.text
        }
        
        self.updateForm()
    }
    
    // MARK: - Helper functions
    private func configureUI() {
        view.backgroundColor = Constants.primaryColor
        let usernameTextField = UQTextField(placeholder: "Nombre")
        self.usernameTextField = usernameTextField
        let lastnameTextField = UQTextField(placeholder: "Apellidos")
        self.lastnameTextField = lastnameTextField
        let emailTextField = UQTextField(placeholder: "Email")
        emailTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        self.emailTextField = emailTextField
        let passwordTextField = UQTextField(placeholder: "Password")
        passwordTextField.isSecureTextEntry = true
        self.passwordTextField = passwordTextField
        
        let signUpButton = UIButton()
        signUpButton.setTitle("Regístrate", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.3501588404, green: 0.4323381186, blue: 0.6990520358, alpha: 1).withAlphaComponent(0.5)
        signUpButton.layer.cornerRadius = 5
        signUpButton.setHeight(50)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpButton.isEnabled = false
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
    
    func configureNotificationObservers() {
        guard let emailTextField = emailTextField, let passwordTextField = passwordTextField, let usernameTextField = usernameTextField, let lastnameTextField = lastnameTextField else {
            return
        }
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        lastnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - FormViewModel
extension RegistrationController: FormViewModel {
    func updateForm() {
        guard let signUpButton = signUpButton else { return }
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}
