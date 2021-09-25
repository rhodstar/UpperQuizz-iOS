//
//  examenTerminado.swift
//  UpperQuizz
//
//  Created by Hernán Galileo Cabrera Garibaldi on 20/08/21.
//

struct examenTerminado: Codable {
    var evaluacionId: Int
    var aciertosTotales: Int
    var puntajeMateria: [puntaje_materia]
    var numIntento: Int
    var fechaAplicacion: String?
}

struct puntaje_materia: Codable {
    var materiaId: Int
    var nombreMateria: String
    var puntaje: Int
}

