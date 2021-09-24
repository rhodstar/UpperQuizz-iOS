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
    
    private var viewModel: QuizzViewModel?
    
    var questions: [Question]?
    var questionIndex: Int = 0 {
        didSet {
            updateNavButtons()
        }
    }
    
    var answers: [Int?]? {
        didSet {
            nextButtonColors()
        }
    }

    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadQuestions()
        viewModel = QuizzViewModel(questions: self.questions)
    }
    
    //MARK:- Helpers
    func configureQuestion(index: Int) {
        let currentQuestion = questions?[index]
        self.title = "Pregunta \(index + 1)"
        subjectLabel?.text = currentQuestion?.materia
        questionTextLabel?.text = currentQuestion?.texto_pregunta
        optionsTableView?.reloadData()
    }
    
    @objc func handleNextQuestion() {
        guard let questions = questions else { return }
        if questionIndex < questions.count - 1 {
            if answers?[questionIndex] != nil { // nil = NO option selected
                questionIndex += 1
                configureQuestion(index: questionIndex)
                nextButtonColors()
            } else { print("No se ha seleccionado, ninguna opcion") }
        } else {
            // User pressed Finished button
            presentGrades()
        }
    }
    
    @objc func handlePrevQuestion() {
        if questionIndex != 0 {
            questionIndex -= 1
            configureQuestion(index: questionIndex)
        }
    }
    
    func presentGrades() {
        viewModel?.gradeExam(answers: answers)
        let totalPoints = viewModel?.totalPoints
        let pointsBySubject = viewModel?.pointsBySubject
        
        let puntajesMateria = [
            puntaje_materia(materia_id: 1, nombre_materia: "Matemáticas", puntaje: pointsBySubject?[0] ?? 0),
            puntaje_materia(materia_id: 2, nombre_materia: "Español", puntaje: pointsBySubject?[1] ?? 0),
            puntaje_materia(materia_id: 3, nombre_materia: "Física", puntaje: pointsBySubject?[2] ?? 0),
            puntaje_materia(materia_id: 4, nombre_materia: "Química", puntaje: pointsBySubject?[3] ?? 0),
            puntaje_materia(materia_id: 5, nombre_materia: "Biología", puntaje: pointsBySubject?[4] ?? 0),
            puntaje_materia(materia_id: 6, nombre_materia: "Historia Universal", puntaje: pointsBySubject?[5] ?? 0),
            puntaje_materia(materia_id: 7, nombre_materia: "Historia de México", puntaje: pointsBySubject?[6] ?? 0),
            puntaje_materia(materia_id: 8, nombre_materia: "Literatura", puntaje: pointsBySubject?[7] ?? 0),
            puntaje_materia(materia_id: 9, nombre_materia: "Geografía", puntaje: pointsBySubject?[8] ?? 0),
            puntaje_materia(materia_id: 10, nombre_materia: "Filosofía", puntaje: pointsBySubject?[9] ?? 0),
        ]
        let today = "\(Date())"
        let newExamenTerminado = examenTerminado(evaluacion_id: 1, aciertos_totales: totalPoints ?? 0, fecha_aplicacion: today, puntaje_materia: puntajesMateria)
        
        let detailVcc = DetailVC()
        detailVcc.examenTerminado = newExamenTerminado
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVcc, animated: true)
    }
    
    //MARK:- UI Helpers
    func updateNavButtons() {
        prevButton?.backgroundColor = viewModel?.prevButtonBackground(index: questionIndex)
        nextButtonColors()
    }
    
    func nextButtonColors() {
        let title = viewModel?.nextButTitle(index: questionIndex)
        nextButton?.setTitle(title, for: .normal)
        nextButton?.backgroundColor = viewModel?.nextButColor(index: questionIndex, answers: answers)
        let textColor = viewModel?.nextButTextColor(index: questionIndex, answers: answers)
        nextButton?.setTitleColor(textColor, for: .normal)
    }
    
    func configureViewController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Pregunta ##"
    }
}

// MARK:- TableView Data Source
extension QuizzViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?[questionIndex].opciones.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.reuseId, for: indexPath) as! OptionCell
        let option = questions?[questionIndex].opciones[indexPath.row]
        cell.option = option
        
        cell.wasSelected = viewModel?.setWasSelectedFlag(index: questionIndex, answers: answers, optionId: option?.opcion_id)
        
        return cell
    }
}

// MARK:- TableView Data source
extension QuizzViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        answers?[questionIndex] = questions?[questionIndex].opciones[indexPath.row].opcion_id
        tableView.reloadData()
    }
}

// MARK:- Constraints UI configuration
extension QuizzViewController {
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
        configureViewController()
        configureContainterUI()
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
        nextButton.backgroundColor = Constants.culturedColor
        nextButton.setTitleColor(.brown, for: .normal)
        nextButton.addTarget(self, action: #selector(handleNextQuestion),for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nextButton)
        self.nextButton = nextButton

        let prevButton = UIButton()
        prevButton.setTitle("Anterior", for: .normal)
        prevButton.backgroundColor = Constants.secondaryColor
        prevButton.setTitleColor(.brown, for: .normal)
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
            nextButton.heightAnchor.constraint(equalToConstant: 40),

            prevButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            prevButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            prevButton.widthAnchor.constraint(equalToConstant: 150),
            prevButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK:- Temporal extension for fake Data
extension QuizzViewController {
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
            Question(texto_pregunta: "¿Cómo estas?", opcion_correcta_id: 2, pregunta_id: 1, materia: "Matemáticas", materia_id: 1, opciones: optionsQ1),
            Question(texto_pregunta: "4+3", opcion_correcta_id: 6, pregunta_id: 2, materia:"Matemáticas", materia_id: 1, opciones: optionsQ2),
            Question(texto_pregunta: "7-2", opcion_correcta_id: 9, pregunta_id: 3, materia:"Matemáticas", materia_id: 1, opciones: optionsQ3),
            Question(texto_pregunta: "11-20", opcion_correcta_id: 15, pregunta_id: 4, materia:"Español", materia_id: 2, opciones: optionsQ4),
            Question(texto_pregunta: "3+3", opcion_correcta_id: 18, pregunta_id: 5, materia:"Español", materia_id: 2, opciones: optionsQ5),
            Question(texto_pregunta: "4+3", opcion_correcta_id: 21, pregunta_id: 6, materia:"Física", materia_id: 3, opciones: optionsQ6),
        ]
        
        self.questions = questions
        // Initializiting array of answers
        // This array will help us count wrong and good answers
        // And redraw previous answered questions.
        self.answers = Array(repeating: nil, count: questions.count)
        
        configureQuestion(index: 0)
    }
}
