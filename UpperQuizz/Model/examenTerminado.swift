//
//  examenTerminado.swift
//  UpperQuizz
//
//  Created by Hernán Galileo Cabrera Garibaldi on 20/08/21.
//

struct examenTerminado: Codable {
    var evaluacion_id: Int
    var aciertos_totales: Int
    var fecha_aplicacion: String
    var puntaje_materia: [puntaje_materia]
}

struct puntaje_materia: Codable {
    var materia_id: Int
    var nombre_materia: String
    var puntaje: Int
}

