//
//  AuthService.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 15/09/21.
//

import UIKit
import Alamofire

final class AuthenticationService {
    static let sharedInstance = AuthenticationService()
    typealias K = Constants
    typealias RegisterCompletion = (String) -> Void
    typealias AuthCompletion = (Result<User?, AuthError>) -> Void
    
    func logUserIn(with credentials: LoginCredentials, completion: @escaping(AuthCompletion)) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(K.LOGIN_ENDPOINT, method: .post, parameters: credentials, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do{
                    guard let data = data else { return }
                    let user = try JSONDecoder().decode(User.self, from: data)
                    if response.response?.statusCode == 200 {
                        completion(.success(user))
                    } else {
                        completion(.failure(.incorrectCredentials(message: "Verifica que los datos sean correctos")))
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                    completion(.failure(.incorrectCredentials(message: "Verifica que los datos sean correctos")))
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(.failure(.networkError(message: "Hay problemas de conexión, intentelo más tarde")))
            }
        }
    }
    
    @objc func logUserOut(viewController: UIViewController) {
        UserService.shared.removeToken()
        
        let loginController = LoginController()
        loginController.delegate = viewController.tabBarController as? MainTabBarController
        let nav = UINavigationController(rootViewController: loginController)
        nav.modalPresentationStyle = .fullScreen
        viewController.present(nav, animated: true)
    }
    
    func registerUser(with credentials: RegisterCredentials, completion: @escaping(RegisterCompletion)) {
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(K.REGISTER_ENDPOINT, method: .post, parameters: credentials, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do{
                    guard let data = data else { return }
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    debugPrint(jsonResponse)
                    if response.response?.statusCode == 200 {
                        completion("Usuario creado correctamente")
                    } else {
                        completion("Hubo un problema al crear el usuario, verifica tus datos")
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                    completion("Se produjó un error al crear el usuario, intentalo más tarde")
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion("Problemas de conexión, intentalo más tarde")
            }
        }
    }
}
