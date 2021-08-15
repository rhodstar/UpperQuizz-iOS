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
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

//    model View
//    View
    func configureLayout(){
        let tableView = UITableView()
        tableView.register(CellView.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
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

//Extension
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
        viewCell.gameSeriesLabel.text = "Puntaje obtenido: " + String(progressData2!.historialEvaluaciones[indexPath.row].puntajeTotal)
        viewCell.circularProgress.progress = CGFloat(Float(progressData2?.historialEvaluaciones[indexPath.row].puntajeTotal ?? 1))/10
        return cell
    }
}
// MARK: - Extension for Delegate Table
extension ProgressController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVcc = DetailVC()
        detailVcc.CircularProgress.progress = CGFloat(Float(progressData2?.historialEvaluaciones[indexPath.row].puntajeTotal ?? 1))/10
        detailVcc.nameLabel.text = progressData2?.historialEvaluaciones[indexPath.row].nombreExamen
        self.present(detailVcc, animated: true)
    }
}
