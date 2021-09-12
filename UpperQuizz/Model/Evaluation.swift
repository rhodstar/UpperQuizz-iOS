//
//  Evaluation.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 30/07/21.
//

import Foundation

// MARK: - Evalucion
struct Evaluation: Codable {
    let examenId: Int
    let nombreExamen: String
    let status: EvaluationState
    let aciertos, numPreguntasContestadas, totalPreguntas, intentos: Int
}

enum EvaluationState: String, Codable {
    case finished = "T"
    case incomplete = "I"
    case initial = "N"
}

