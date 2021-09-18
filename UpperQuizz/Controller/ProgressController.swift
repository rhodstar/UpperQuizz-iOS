//
//  ProgressController.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 20/07/21.
//

import UIKit

// MARK: - MainTabController Class
final class ProgressController: UIViewController {
    
    private weak var tableView: UITableView?
    let progressData2 = LocalDataManager.getData(of: miProgreso.self, from: "mi_progreso")
    let examenTermiando2 = LocalDataManager.getData(of: examenTerminado.self, from: "examen_terminado")
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

// MARK: - Configure Layout
    func configureLayout(){
        let tableView = UITableView()
        tableView.register(CellView.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView = tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo:
            view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo:
            view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo:
            view.bottomAnchor)
        ])
    }
}

// MARK: - Extensión ProgressController
extension ProgressController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressData2?.historialEvaluaciones.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let viewCell = cell as? CellView else {
            return cell
        }
        viewCell.nameLabel.text = progressData2?.historialEvaluaciones[indexPath.row].nombreExamen
        viewCell.descriptionLabel.text = "Calif: " + String(progressData2!.historialEvaluaciones[indexPath.row].puntajeTotal)
        viewCell.horizontalProgressBar.progress = CGFloat(progressData2!.historialEvaluaciones[indexPath.row].puntajeTotal)/10
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - Extension for Delegate Table
extension ProgressController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVcc = DetailVC()
        detailVcc.examenTerminado = examenTermiando2
        self.present(detailVcc, animated: true)
    }
}

extension ProgressController{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        let label = LabelTittle()
        label.text = "Mi Promedio: " + String(self.progressData2!.promedioGeneral)
        header.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
        label.topAnchor.constraint(equalTo: header.topAnchor, constant: 15)
        ])
        let progresBar = HorizontalProgressBar()
        progresBar.progress = CGFloat(self.progressData2!.promedioGeneral)/10
        header.addSubview(progresBar)
        progresBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progresBar.topAnchor.constraint(equalTo: label.topAnchor, constant: 40),
            progresBar.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            progresBar.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -10),
            progresBar.heightAnchor.constraint(equalToConstant: 10)
        ])
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}
