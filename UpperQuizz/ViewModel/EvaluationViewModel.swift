//
//  EvaluationViewModel.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 10/09/21.
//

import UIKit

struct EvaluationViewModel {
    let evaluation: Evaluation
    
    init(evaluation: Evaluation) {
        self.evaluation = evaluation
    }
    
    var completionPercentage: Double {
        return Double(evaluation.numPreguntasContestadas) / Double(evaluation.totalPreguntas)
    }
    
    var colorByStatus: UIColor {
        switch evaluation.status {
        case .finished:
            return Constants.primaryColor
        case .incomplete:
            return UIColor.systemGreen
        case .initial:
            return UIColor.systemGray
        }
    }
    
    var subtitleMessage: String {
        switch evaluation.status {
        case .finished:
            let score = Double(evaluation.aciertosTotales * 10) / Double(evaluation.totalPreguntas)
            return String(format: "Calificación: %.1f de 10.0", score)
        case .incomplete:
            return "Continuar examen >"
        case .initial:
            return "Iniciar examen"
        }
    }
    
    var isInitialEvaluation: Bool {
        return evaluation.status == .initial
    }
    
    var completePercentage: String {
        let percentage = Double(evaluation.numPreguntasContestadas) / Double(evaluation.totalPreguntas) * 100
        return "\(Int(percentage))%"
    }
}
