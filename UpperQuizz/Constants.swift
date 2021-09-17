//
//  Constants.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 16/08/21.
//

import UIKit

struct Constants {
    /* COLOR CONSTANTS */
    static let evaluationTitle = "Evaluaciones"
    static let reminderTitle = "Recordatorios"
    static let backgroundColor = UIColor(rgb: 0xFAFAFF)
    static let primaryColor = UIColor(rgb: 0x3C4E90)
    
    //Constants for ReminderCell
    static let cellHeight: CGFloat = 160
    static let reminderItemTitle = "Primera vuelta UNAM"
    static let reminderAnnounceText = "Fecha de la convocatoria"
    static let reminderExamDateText = "Fecha del examen"
    static let reminderSeeMore = "Ver más"
    
    //Constants for ReminderController
    static let backupURL = "https://blog.unitips.mx"

    static let secondaryColor = UIColor(rgb: 0xDADDD8)
    
    /* NETWORK CONSTANTS */
    static let BASE_URL = "https://upper-quizz.herokuapp.com/v1"
    static let REGISTER_ENDPOINT = BASE_URL + "/register"
    static let LOGIN_ENDPOINT = BASE_URL + "/login"
    
    /* USER DEFAULTS */
    static let USER_LOGIN = "user_token"
}
