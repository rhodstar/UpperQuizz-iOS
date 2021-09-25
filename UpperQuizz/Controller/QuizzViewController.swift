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
    
    public var evaluation: Evaluation?
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
    }
    
    //MARK:- Networking
    func loadQuestions() {
        guard let evaluation = evaluation else { return }
        QuizzService.sharedInstance.getEvaluation(evaluationID: evaluation.evaluacionId) { [weak self] result in
            switch result {
            case .success(let evaluation):
                self?.questions = evaluation
                //self.questions = questions
                // Initializiting array of answers
                // This array will help us count wrong and good answers
                // And redraw previous answered questions.
                self?.answers = Array(repeating: nil, count: (self?.questions!.count)!)
                self?.viewModel = QuizzViewModel(questions: self?.questions)
                DispatchQueue.main.async {
                    self?.configureQuestion(index: 0)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func saveSelectedOption(evaluationId: Int, questionId: Int, optionId: Int) {
        QuizzService.sharedInstance.saveSelectedOption(evaluationId: evaluationId, questionId: questionId, selectedOptionId: optionId) { message in
            DispatchQueue.main.async {
                print(message)
            }
        }
    }
    
    func saveGrades(evaluationId: Int, answers: examenTerminado) {
        QuizzService.sharedInstance.saveEvaluation(evaluationId: evaluationId, answers: answers) { message in
            DispatchQueue.main.async {
                print(message)
            }
        }
    }
    
    //MARK:- Helpers
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
    
    func configureQuestion(index: Int) {
        let currentQuestion = questions?[index]
        self.title = "Pregunta \(index + 1)"
        subjectLabel?.text = currentQuestion?.materia
        questionTextLabel?.text = currentQuestion?.textoPregunta
        optionsTableView?.reloadData()
    }
    
    func presentGrades() {
        viewModel?.gradeExam(answers: answers)
        let totalPoints = viewModel?.totalPoints
        let pointsBySubject = (viewModel?.pointsBySubject)!
        
        let subjects = Constants.subjects
        
        var puntajesMateria: [puntaje_materia] = []
        
        for i in 0..<subjects.count {
            puntajesMateria.append(puntaje_materia(materiaId: i+1, nombreMateria: subjects[i], puntaje: pointsBySubject[i] ))
        }
        
        let today = "\(Date())"
        let newExamenTerminado = examenTerminado(evaluacionId: 1, aciertosTotales: totalPoints ?? 0, puntajeMateria: puntajesMateria, numIntento: 1, fechaAplicacion: today)
        
        saveGrades(evaluationId: evaluation!.evaluacionId, answers: newExamenTerminado)
        
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
        cell.wasSelected = viewModel?.setWasSelectedFlag(index: questionIndex, answers: answers, optionId: option?.opcionId)
        
        return cell
    }
}

// MARK:- TableView Data source
extension QuizzViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionId = questions?[questionIndex].opciones[indexPath.row].opcionId
        let questionId = questions?[questionIndex].preguntaId
        answers?[questionIndex] = optionId
        tableView.reloadData()
        
        saveSelectedOption(evaluationId: evaluation!.evaluacionId, questionId: questionId!, optionId: optionId!)
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
        questionTextLabel.lineBreakMode = .byWordWrapping
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
            
            optionsTableView.topAnchor.constraint(equalTo: questionTextLabel.bottomAnchor, constant: 15),
            optionsTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            optionsTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            optionsTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -70),
            
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
