//
//  QuizzViewModel.swift
//  UpperQuizz
//
//  Created by maxwell on 23/09/21.
//

import UIKit

struct QuizzViewModel {
    let questions: [Question]?
    public var totalPoints: Int = 0
    public var pointsBySubject: [Int]? = Array(repeating: 0, count: 10) // 10 = num of subjects in the DB
    
    mutating func gradeQuestion(index: Int, answers: [Int?]?) {
        guard let questions = questions else { return }
        if answers?[index] == questions[index].opcion_correcta_id {
            totalPoints += 1
            let materia_id = questions[index].materia_id
            //TODO:- Maybe consider changing materia_id as the index
            pointsBySubject?[materia_id - 1] += 1
        }
    }
    
    func setWasSelectedFlag(index: Int, answers: [Int?]?, optionId: Int?) -> Bool {
        var wasSelected = false
        if answers?[index] != nil {
            if answers?[index] == optionId {
                wasSelected = true
            } else {
                wasSelected = false
            }
        }
        return wasSelected
    }
}
