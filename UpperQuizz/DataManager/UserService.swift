//
//  UserService.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 16/09/21.
//

import Foundation

// MARK: - UserService
final class UserService {
    static let shared = UserService()
    
    var apiToken: String? {
        return UserDefaults.standard.string(forKey: Constants.USER_LOGIN)
    }
    
    var isUserLoggedIn: Bool {
        return apiToken != nil
    }
    
    func saveToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: Constants.USER_LOGIN)
    }
    
    func removeToken() {
        UserDefaults.standard.removeObject(forKey: Constants.USER_LOGIN)
    }
}
