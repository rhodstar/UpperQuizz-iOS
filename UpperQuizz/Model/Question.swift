//
//  Question.swift
//  UpperQuizz
//
//  Created by Rodrigo Francisco on 20/09/21.
//

import UIKit

struct  Question {
    let texto_pregunta: String
    let opcion_correcta_id: Int
    let pregunta_id: Int
    let materia: String
    let materia_id: Int
    let opciones: [Option]
}
