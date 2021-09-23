//
//  QuizzViewModel.swift
//  UpperQuizz
//
//  Created by maxwell on 23/09/21.
//

import UIKit

struct QuizzViewModel {
    let questions: [Question]?
    
    func gradeQuestion(index: Int, answers: [Int?]?, bySubject pointsBySubject: inout [Int]?) -> Int {
        guard let questions = questions else { return 0}
        var totalPoints = 0
        print("answesIndex: \(answers?[index] ?? -1)")
        if answers?[index] == questions[index].opcion_correcta_id {
            totalPoints += 1
            let materia_id = questions[index].materia_id
            //TODO:- Maybe consider changing materia_id as the index
            pointsBySubject?[materia_id - 1] += 1
        }
        
        return totalPoints
    }
}
