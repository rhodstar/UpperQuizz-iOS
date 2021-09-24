//
//  Evaluation.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 30/07/21.
//

import Foundation

// MARK: - Evalucion
struct Evaluation: Codable {
    let aciertosTotales, evaluacionId, examenId, numIntento: Int
    let nombreExamen: String
    let numPreguntasContestadas: Int
    let status: EvaluationState
    let totalPreguntas: Int
}

enum EvaluationState: String, Codable {
    case finished = "TERMINADO"
    case incomplete = "INCONCLUSO"
    case initial = "NUNCA"
}

