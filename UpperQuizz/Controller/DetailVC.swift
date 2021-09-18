//
//  DetailVC.swift
//  UpperQuizz
//
//  Created by Hernán Galileo Cabrera Garibaldi on 14/08/21.
//

import UIKit
class DetailVC: UIViewController, UITableViewDelegate{
    
    private weak var tableView: UITableView?
    var examenTerminado: examenTerminado?
//    -------------
    var lenData: Int = 0
    var labelMateria = LabelTittle()
//    -------------
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
// MARK: - Configure Layout
    func configureLayout(){
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CellView.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView = tableView
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examenTerminado?.puntaje_materia.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let viewCell = cell as? CellView else {
            return cell
        }
        viewCell.iconView = UIImageView(image: UIImage(systemName: "doc.plaintext.fill"))
        viewCell.nameLabel.text = examenTerminado?.puntaje_materia[indexPath.row].nombre_materia
        viewCell.horizontalProgressBar.progress = CGFloat((examenTerminado?.puntaje_materia[indexPath.row].puntaje ?? 0))/10
        //CGFloat((examenTerminado?.puntaje_materia[indexPath.row].puntaje)!)*10
        viewCell.descriptionLabel.text = "Aciertos: " + String((examenTerminado?.puntaje_materia[indexPath.row].puntaje ?? 0))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension DetailVC{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 120))
        if (examenTerminado != nil){
            labelMateria.text = "Calificación de examen: " + String(examenTerminado!.aciertos_totales)
        }else{
            labelMateria.text = "Calificación de examen: 0"
        }
        
        header.addSubview(labelMateria)
        labelMateria.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        labelMateria.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            labelMateria.topAnchor.constraint(equalTo: header.topAnchor, constant: 15)
        ])
        let progresBar = HorizontalProgressBar()
        if (examenTerminado != nil){
            progresBar.progress = CGFloat(examenTerminado!.aciertos_totales)/10
        }else{
            progresBar.progress = 0.01
        }
        
        header.addSubview(progresBar)
        progresBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progresBar.topAnchor.constraint(equalTo: labelMateria.topAnchor, constant: 40),
            progresBar.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            progresBar.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -10),
            progresBar.heightAnchor.constraint(equalToConstant: 10)
        ])
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
}
