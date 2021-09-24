//
//  EvaluationService.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 23/09/21.
//

import Foundation
import Alamofire

final class EvaluationService {
    static let shared = EvaluationService()
    typealias K = Constants
    typealias EvaluationCompletion = (Result<[Evaluation], Error>) -> Void
    
    func getEvaluations(completion: @escaping(EvaluationCompletion)) {
        guard let token = UserService.shared.apiToken else { return }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": token
        ]
        AF.request(K.EVALUATION_ENDPOINT, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let evaluations = try decoder.decode([Evaluation].self, from: data)
                    if response.response?.statusCode == 200 {
                        completion(.success(evaluations))
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
}
