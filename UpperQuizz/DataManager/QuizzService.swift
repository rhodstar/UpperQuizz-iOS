//
//  QuizzService.swift
//  UpperQuizz
//
//  Created by Rodrigo Francisco on 20/09/21.
//

import UIKit
import Alamofire

final class QuizzService {
    static let sharedInstance = QuizzService()
    typealias K = Constants
    typealias QuizzCompletion = (Result<[Question], Error>) -> Void
    typealias OptionEvaluationCompletion = (String) -> Void
    typealias AnswersCompletion = (String) -> Void
    
    func getEvaluation(evaluationID: Int, completion: @escaping(QuizzCompletion)) {
        guard let token = UserService.shared.apiToken else { return }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": token
        ]
        
        AF.request(K.EVALUATION_ENDPOINT+"/\(evaluationID)", headers: headers).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let evaluation = try decoder.decode([Question].self, from: data)
                    if response.response?.statusCode == 200 {
                        completion(.success(evaluation))
                    }
                } catch {
                    debugPrint(error)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func saveSelectedOption(evaluationId:Int, questionId:Int, selectedOptionId: Int, completion: @escaping(OptionEvaluationCompletion) ) {
        guard let token = UserService.shared.apiToken else { return }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": token
        ]
        
        let endPoint = "\(K.EVALUATION_ENDPOINT)/\(evaluationId)/pregunta/\(questionId)"
        
        let params = EvaluationOption(opcionSeleccionadaId: selectedOptionId)
        let encoder = JSONParameterEncoder()
        encoder.encoder.keyEncodingStrategy = .convertToSnakeCase
        
        AF.request(endPoint,method: .post, parameters: params, encoder: encoder, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do{
                    guard let data = data else { return }
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    debugPrint(jsonResponse)
                    if response.response?.statusCode == 200 {
                        completion("Opcion guardada correctamente")
                    } else {
                        completion("Hubo un problema, verifica tus datos")
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                    completion("Error al guardar la opcion selecionada")
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion("Problemas de conexión, intentalo más tarde")
            }
        }
    }
    
    func saveEvaluation(evaluationId:Int, answers: examenTerminado,completion: @escaping(AnswersCompletion)) {
        guard let token = UserService.shared.apiToken else { return }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": token
        ]
        
        let endPoint = "\(K.EVALUATION_ENDPOINT)/\(evaluationId)/calificar"
        let encoder = JSONParameterEncoder()
        encoder.encoder.keyEncodingStrategy = .convertToSnakeCase
        
        AF.request(endPoint,method: .post, parameters: answers, encoder: encoder, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do{
                    guard let data = data else { return }
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    debugPrint(jsonResponse)
                    if response.response?.statusCode == 200 {
                        completion("Opcion guardada correctamente")
                    } else {
                        completion("Hubo un problema, verifica tus datos")
                    }
                } catch {
                    debugPrint(error.localizedDescription)
                    completion("Error al guardar la opcion selecionada")
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion("Problemas de conexión, intentalo más tarde")
            }
        }
    }
}
