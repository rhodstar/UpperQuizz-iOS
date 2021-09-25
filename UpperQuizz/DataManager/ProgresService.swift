//
//  ProgresService.swift
//  UpperQuizz
//
//  Created by Hernán Galileo Cabrera Garibaldi on 24/09/21.
//

import Alamofire
import Foundation

final class ProgresService {
    static let shared = ProgresService()
    typealias K = Constants
    typealias progresCompletion = (Result<miProgreso, Error>) -> Void
    typealias detailProgressCompletion = (Result<examenTerminado, Error>) -> Void
    
    func getProgress(completion: @escaping(progresCompletion)) {
        guard let token = UserService.shared.apiToken else { return }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": token
        ]
        AF.request(K.PROGRESS_ENDPOINT, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let progres = try decoder.decode(miProgreso.self, from: data)
                    if response.response?.statusCode == 200 {
                        completion(.success(progres))
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
    func getDetail(evaluationId: Int, completion: @escaping(detailProgressCompletion)) {
        guard let token = UserService.shared.apiToken else { return }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "x-access-token": token
        ]
        AF.request(K.PROGRESS_ENDPOINT+"/\(evaluationId)", headers: headers).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let progres = try decoder.decode(examenTerminado.self, from: data)
                    if response.response?.statusCode == 200 {
                        completion(.success(progres))
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
