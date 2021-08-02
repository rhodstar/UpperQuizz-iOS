//
//  miProgreso.swift
//  UpperQuizz
//  Entidad de una BD =mi_progreso = Struct,Heredar de Codable (Encondable y Decodable)
//  Created by Hernán Galileo Cabrera Garibaldi on 31/07/21.
//

struct miProgreso: Codable {
//  Dato unico
    var promedioGeneral: Float
//  Arreglo de otros datos
    var historialEvaluaciones: [historialEvalucaciones]
}
struct historialEvalucaciones: Codable {
    var nombreExamen: String
    var puntajeTotal: Int
    var evaluacionID: Int
}
