//
//  QuizzViewController.swift
//  UpperQuizz
//
//  Created by Rodrigo Francisco on 20/09/21.
//

import UIKit

final class QuizzViewController: UIViewController {
    
    //MARK:- Properties
    private weak var containerView: UIView?
    private weak var subjectLabel: UILabel?
    private weak var questionTextLabel: UILabel?
    
    private weak var optionTextBoxA: UILabel?
    private weak var optionTextBoxB: UILabel?
    private weak var optionTextBoxC: UILabel?
    private weak var optionTextBoxD: UILabel?
    
    private weak var nextButton: UIButton?
    private weak var prevButton: UIButton?
    
    var questions: [Question]?
    var questionIndex: Int = 0

    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureContainterUI()
        configureUI()
        loadQuestions()
        configureQuestion(index: 0)
    }
    
    //MARK:- Helpers
    func loadQuestions() {
        let optionsQ1 = [
            Option(opcion_id: 1, texto_opcion: "Bien"),
            Option(opcion_id: 2, texto_opcion: "Mal"),
            Option(opcion_id: 3, texto_opcion: "Regular"),
            Option(opcion_id: 4, texto_opcion: "No me quejo"),
        ]
        let optionsQ2 = [
            Option(opcion_id: 5, texto_opcion: "5"),
            Option(opcion_id: 6, texto_opcion: "7"),
            Option(opcion_id: 7, texto_opcion: "9"),
            Option(opcion_id: 8, texto_opcion: "12"),
        ]
        let questions = [
            Question(texto_pregunta: "¿Cómo estas?", opcion_correcta_id: 2, pregunta_id: 1, materia: "Matemáticas", opciones: optionsQ1),
            Question(texto_pregunta: "4+3", opcion_correcta_id: 6, pregunta_id: 2, materia:"Matemáticas", opciones: optionsQ2),
        ]
        
        self.questions = questions
    }
    
    func configureQuestion(index: Int) {
        let currentQuestion = questions?[index]
        self.title = "Pregunta \(index + 1)"
        subjectLabel?.text = currentQuestion?.materia
        questionTextLabel?.text = currentQuestion?.texto_pregunta
        optionTextBoxA?.text = currentQuestion?.opciones[0].texto_opcion
        optionTextBoxB?.text = currentQuestion?.opciones[1].texto_opcion
        optionTextBoxC?.text = currentQuestion?.opciones[2].texto_opcion
        optionTextBoxD?.text = currentQuestion?.opciones[3].texto_opcion
    }
    
    //MARK:- UI Helpers
    func configureViewController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Pregunta ##"
    }
    
    func configureContainterUI() {
        let containerView  = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        self.containerView = containerView
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

    func configureUI() {
        view.backgroundColor = .clear
        guard let containerView = containerView else { return }
        let subjectLabel = UILabel()
        subjectLabel.text = "Materia ..."
        subjectLabel.textColor = .gray
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subjectLabel)
        self.subjectLabel = subjectLabel
        
        let questionTextLabel = UILabel()
        questionTextLabel.text = "..."
        questionTextLabel.numberOfLines = 0
        questionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(questionTextLabel)
        self.questionTextLabel = questionTextLabel
        
        let cardBoxViewA = UIView()
        cardBoxViewA.backgroundColor = .white
        cardBoxViewA.cardStyle()
        cardBoxViewA.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cardBoxViewA)
        
        let cardBoxViewB = UIView()
        cardBoxViewB.backgroundColor = .white
        cardBoxViewB.cardStyle()
        cardBoxViewB.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cardBoxViewB)
        
        let cardBoxViewC = UIView()
        cardBoxViewC.backgroundColor = .white
        cardBoxViewC.cardStyle()
        cardBoxViewC.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cardBoxViewC)
        
        let cardBoxViewD = UIView()
        cardBoxViewD.backgroundColor = .white
        cardBoxViewD.cardStyle()
        cardBoxViewD.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cardBoxViewD)
        
        let optionTextBoxA = UILabel()
        optionTextBoxA.text = "Opción A"
        optionTextBoxA.numberOfLines = 0
        optionTextBoxA.translatesAutoresizingMaskIntoConstraints = false
        cardBoxViewA.addSubview(optionTextBoxA)
        self.optionTextBoxA = optionTextBoxA
        
        let optionTextBoxB = UILabel()
        optionTextBoxB.text = "Opción B"
        optionTextBoxB.numberOfLines = 0
        optionTextBoxB.translatesAutoresizingMaskIntoConstraints = false
        cardBoxViewB.addSubview(optionTextBoxB)
        self.optionTextBoxB = optionTextBoxB
        
        let optionTextBoxC = UILabel()
        optionTextBoxC.text = "Opción C"
        optionTextBoxC.numberOfLines = 0
        optionTextBoxC.translatesAutoresizingMaskIntoConstraints = false
        cardBoxViewC.addSubview(optionTextBoxC)
        self.optionTextBoxC = optionTextBoxC
        
        let optionTextBoxD = UILabel()
        optionTextBoxD.text = "Opción D"
        optionTextBoxD.numberOfLines = 0
        optionTextBoxD.translatesAutoresizingMaskIntoConstraints = false
        cardBoxViewD.addSubview(optionTextBoxD)
        self.optionTextBoxD = optionTextBoxD
        
        let nextButton = UIButton()
        nextButton.setTitle("Siguiente", for: .normal)
        nextButton.backgroundColor = Constants.primaryColor
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nextButton)
        self.nextButton = nextButton
        
        let prevButton = UIButton()
        prevButton.setTitle("Anterior", for: .normal)
        prevButton.backgroundColor = Constants.primaryColor
        prevButton.setTitleColor(.white, for: .normal)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(prevButton)
        self.prevButton = prevButton
        
        NSLayoutConstraint.activate([
            subjectLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            subjectLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            questionTextLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 20),
            questionTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            questionTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            cardBoxViewA.topAnchor.constraint(equalTo: questionTextLabel.bottomAnchor, constant: 30),
            cardBoxViewA.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cardBoxViewA.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            cardBoxViewA.heightAnchor.constraint(equalTo: optionTextBoxA.heightAnchor, constant: 30),
            
            cardBoxViewB.topAnchor.constraint(equalTo: cardBoxViewA.bottomAnchor, constant: 20),
            cardBoxViewB.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cardBoxViewB.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            cardBoxViewB.heightAnchor.constraint(equalTo: optionTextBoxB.heightAnchor, constant: 30),
            
            cardBoxViewC.topAnchor.constraint(equalTo: cardBoxViewB.bottomAnchor, constant: 20),
            cardBoxViewC.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cardBoxViewC.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            cardBoxViewC.heightAnchor.constraint(equalTo: optionTextBoxC.heightAnchor, constant: 30),
            
            cardBoxViewD.topAnchor.constraint(equalTo: cardBoxViewC.bottomAnchor, constant: 20),
            cardBoxViewD.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cardBoxViewD.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            cardBoxViewD.heightAnchor.constraint(equalTo: optionTextBoxD.heightAnchor, constant: 30),
            
            optionTextBoxA.topAnchor.constraint(equalTo: cardBoxViewA.topAnchor, constant: 10),
            optionTextBoxA.leadingAnchor.constraint(equalTo: cardBoxViewA.leadingAnchor, constant: 10),
            
            optionTextBoxB.topAnchor.constraint(equalTo: cardBoxViewB.topAnchor, constant: 10),
            optionTextBoxB.leadingAnchor.constraint(equalTo: cardBoxViewB.leadingAnchor, constant: 10),
            
            optionTextBoxC.topAnchor.constraint(equalTo: cardBoxViewC.topAnchor, constant: 10),
            optionTextBoxC.leadingAnchor.constraint(equalTo: cardBoxViewC.leadingAnchor, constant: 10),
            
            optionTextBoxD.topAnchor.constraint(equalTo: cardBoxViewD.topAnchor, constant: 10),
            optionTextBoxD.leadingAnchor.constraint(equalTo: cardBoxViewD.leadingAnchor, constant: 10),
            
            nextButton.topAnchor.constraint(equalTo: cardBoxViewD.bottomAnchor, constant: 50),
            nextButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            prevButton.topAnchor.constraint(equalTo: cardBoxViewD.bottomAnchor, constant: 50),
            prevButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            prevButton.widthAnchor.constraint(equalToConstant: 150),
            prevButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
