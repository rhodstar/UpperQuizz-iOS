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
    typealias QuizzCompletion = (Result<Question?, AuthError>) -> Void
    
    func getEvaluation(evaluationID: Int, completion: @escaping(QuizzCompletion)) {
        print("Hola")
    }
}
