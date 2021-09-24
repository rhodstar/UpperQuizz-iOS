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
    
    mutating func gradeExam(answers: [Int?]?) {
        guard let questions = questions else { return }
        guard let answers = answers else { return }
        var index = 0
        for answer in answers {
            if answer == questions[index].opcion_correcta_id {
                totalPoints += 1
                let materia_id = questions[index].materia_id
                //TODO:- Maybe consider changing materia_id as the index
                pointsBySubject?[materia_id - 1] += 1
                index += 1
            }
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
    
    func prevButtonBackground(index: Int) -> UIColor {
        if index == 0 {
            return Constants.culturedColor
        }
        return Constants.secondaryColor
    }
    
    func nextButTitle(index: Int) -> String {
        var title = "Siguiente"
        guard let questions = questions else { return ""}
        if index == (questions.count - 1) {
            title = "Terminar"
        }        
        return title
    }
    
    func nextButColor(index: Int, answers: [Int?]?) -> UIColor {
        guard let questions = questions else { return Constants.primaryColor }
        if answers?[index] != nil {
            if index == ( questions.count - 1) {
                return .red
            } else {
                return Constants.primaryColor
            }
        }
        
        return Constants.culturedColor
    }
    func nextButTextColor(index: Int, answers: [Int?]?) -> UIColor {
        guard let questions = questions else { return .white }
        if answers?[index] != nil {
            if index == ( questions.count - 1) {
                return .white
            } else {
                return .white
            }
        }
        
        return .brown
    }
}
