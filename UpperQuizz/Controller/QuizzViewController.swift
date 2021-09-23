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
    private weak var optionsTableView: UITableView?
    private weak var nextButton: UIButton?
    private weak var prevButton: UIButton?
    
    var questions: [Question]?
    var questionIndex: Int = 0 {
        didSet {
            updateNavButtons()
        }
    }
    var answers: [Int?]? {
        didSet {
            updateNextButton()
        }
    }

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
        let optionsQ3 = [
            Option(opcion_id: 9, texto_opcion: "5"),
            Option(opcion_id: 10, texto_opcion: "-2"),
            Option(opcion_id: 11, texto_opcion: "9"),
            Option(opcion_id: 12, texto_opcion: "1"),
        ]
        let optionsQ4 = [
            Option(opcion_id: 13, texto_opcion: "9"),
            Option(opcion_id: 14, texto_opcion: "11"),
            Option(opcion_id: 15, texto_opcion: "-9"),
            Option(opcion_id: 16, texto_opcion: "2"),
        ]
        let optionsQ5 = [
            Option(opcion_id: 17, texto_opcion: "-6"),
            Option(opcion_id: 18, texto_opcion: "6"),
            Option(opcion_id: 19, texto_opcion: "9"),
            Option(opcion_id: 20, texto_opcion: "3"),
        ]
        let optionsQ6 = [
            Option(opcion_id: 21, texto_opcion: "7"),
            Option(opcion_id: 22, texto_opcion: "17"),
            Option(opcion_id: 23, texto_opcion: "27"),
            Option(opcion_id: 24, texto_opcion: "5"),
        ]
        let questions = [
            Question(texto_pregunta: "¿Cómo estas?", opcion_correcta_id: 2, pregunta_id: 1, materia: "Matemáticas", opciones: optionsQ1),
            Question(texto_pregunta: "4+3", opcion_correcta_id: 6, pregunta_id: 2, materia:"Matemáticas", opciones: optionsQ2),
            Question(texto_pregunta: "7-2", opcion_correcta_id: 9, pregunta_id: 3, materia:"Matemáticas", opciones: optionsQ3),
            Question(texto_pregunta: "11-20", opcion_correcta_id: 15, pregunta_id: 4, materia:"Matemáticas", opciones: optionsQ4),
            Question(texto_pregunta: "3+3", opcion_correcta_id: 18, pregunta_id: 5, materia:"Matemáticas", opciones: optionsQ5),
            Question(texto_pregunta: "4+3", opcion_correcta_id: 21, pregunta_id: 6, materia:"Español", opciones: optionsQ6),
        ]
        
        self.questions = questions
        // Initializiting array of answers
        // This array will help us count wrong and good answers
        // And redraw previous answered questions.
        self.answers = Array(repeating: nil, count: questions.count)
    }
    
    func configureQuestion(index: Int) {
        let currentQuestion = questions?[index]
        self.title = "Pregunta \(index + 1)"
        subjectLabel?.text = currentQuestion?.materia
        questionTextLabel?.text = currentQuestion?.texto_pregunta
    }
    
    @objc func handleNextQuestion() {
        guard let questions = questions else { return }
        if questionIndex < questions.count - 1 {
            if answers?[questionIndex] != nil {
                questionIndex += 1
                configureQuestion(index: questionIndex)
                nextButton?.backgroundColor = .gray
                optionsTableView?.reloadData()
            } else {
                print("No se ha seleccionado, ninguna opcion")
            }
        }
    }
    
    @objc func handlePrevQuestion() {
        if questionIndex != 0 {
            questionIndex -= 1
            configureQuestion(index: questionIndex)
            optionsTableView?.reloadData()
        }
    }
    
    //MARK:- UI Helpers
    func updateNavButtons() {
        if questionIndex == 0 {
            prevButton?.backgroundColor = .gray
        } else {
            prevButton?.backgroundColor = Constants.primaryColor
        }
        
        guard let questions = questions else { return }
        if questionIndex == (questions.count - 1) {
            nextButton?.setTitle("Terminar", for: .normal)
        } else {
            nextButton?.backgroundColor = Constants.primaryColor
            nextButton?.setTitle("Siguiente", for: .normal)
        }
    }
    
    func updateNextButton() {
        if answers?[questionIndex] != nil {
            guard let questions = questions else { return }
            if questionIndex == (questions.count - 1) {
                nextButton?.backgroundColor = .red
                nextButton?.setTitle("Terminar", for: .normal)
            } else {
                nextButton?.backgroundColor = Constants.primaryColor
                nextButton?.setTitle("Siguiente", for: .normal)
            }
            
        } else {
            nextButton?.backgroundColor = .gray
        }
    }
    
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
        subjectLabel.font = UIFont.systemFont(ofSize: 20)
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subjectLabel)
        self.subjectLabel = subjectLabel
        
        let questionTextLabel = UILabel()
        questionTextLabel.text = "..."
        questionTextLabel.numberOfLines = 0
        questionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(questionTextLabel)
        self.questionTextLabel = questionTextLabel
        
        let optionsTableView = UITableView()
        optionsTableView.separatorStyle = .none	
        optionsTableView.register(OptionCell.self, forCellReuseIdentifier: OptionCell.reuseId)
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(optionsTableView)
        self.optionsTableView = optionsTableView
        
        let nextButton = UIButton()
        nextButton.setTitle("Siguiente", for: .normal)
        nextButton.backgroundColor = Constants.primaryColor
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(handleNextQuestion),for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nextButton)
        self.nextButton = nextButton

        let prevButton = UIButton()
        prevButton.setTitle("Anterior", for: .normal)
        prevButton.backgroundColor = Constants.primaryColor
        prevButton.setTitleColor(.white, for: .normal)
        prevButton.addTarget(self, action: #selector(handlePrevQuestion), for: .touchUpInside)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(prevButton)
        self.prevButton = prevButton
        
        NSLayoutConstraint.activate([
            subjectLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            subjectLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            
            questionTextLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 20),
            questionTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            questionTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            optionsTableView.topAnchor.constraint(equalTo: questionTextLabel.topAnchor, constant: 40),
            optionsTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            optionsTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            optionsTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -100),
            
            nextButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.heightAnchor.constraint(equalToConstant: 50),

            prevButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            prevButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            prevButton.widthAnchor.constraint(equalToConstant: 150),
            prevButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension QuizzViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?[questionIndex].opciones.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reuseId, for: indexPath) as! OptionCell
        cell.option = questions?[questionIndex].opciones[indexPath.row]
        
        print("Cell was called \(indexPath.row)")
        let currentOptionId = cell.option?.opcion_id
        if answers?[questionIndex] != nil {
            if answers?[questionIndex] == currentOptionId {
                cell.wasSelected = true
            } else {
                cell.wasSelected = false
            }
        }
        return cell
    }
}

extension QuizzViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        answers?[questionIndex] = questions?[questionIndex].opciones[indexPath.row].opcion_id
        tableView.reloadData()
    }
}
