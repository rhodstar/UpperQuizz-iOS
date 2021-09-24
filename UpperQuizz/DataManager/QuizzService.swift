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
}
