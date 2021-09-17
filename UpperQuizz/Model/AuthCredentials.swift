//
//  AuthCredentials.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 15/09/21.
//

import Foundation

struct LoginCredentials: Encodable {
    let correo: String
    let contrasena: String
}

struct RegisterCredentials: Encodable {
    let nombre: String?
    let apellidos: String?
    let correo: String
    let contrasena: String
}

enum AuthError: Error {
    case networkError(message: String)
    case userAlreadyCreated(message: String)
    case incorrectCredentials(message: String)
}
