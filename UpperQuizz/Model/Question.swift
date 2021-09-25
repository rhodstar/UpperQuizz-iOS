//
//  Question.swift
//  UpperQuizz
//
//  Created by Rodrigo Francisco on 20/09/21.
//

import UIKit

struct  Question: Codable {
    let textoPregunta: String
    let opcionCorrectaId: Int
    let preguntaId: Int
    let materia: String
    let materiaId: Int
    let opciones: [Option]
}

struct EvaluationOption: Codable {
    let opcionSeleccionadaId: Int
}
