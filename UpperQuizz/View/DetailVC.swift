//
//  DetailVC.swift
//  UpperQuizz
//
//  Created by Hernán Galileo Cabrera Garibaldi on 14/08/21.
//

import UIKit
class DetailVC: UIViewController{
//
    var miprogreso1: historialEvalucaciones?
//
    var safeArea: UILayoutGuide!
    let CircularProgress = CircularProgressView2()
    let nameLabel = UILabel()
    
    let dissmissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        safeArea = view.layoutMarginsGuide
        setupDismissButton()
        setupCircularProgress()
        setupName()
        setupData()

    }
    func setupCircularProgress(){
        view.addSubview(CircularProgress)
        
        CircularProgress.translatesAutoresizingMaskIntoConstraints = false
        CircularProgress.contentMode = .scaleToFill
        CircularProgress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        CircularProgress.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        CircularProgress.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive = true
        CircularProgress.heightAnchor.constraint(equalTo: CircularProgress.widthAnchor).isActive = true
        
    }
    func setupDismissButton(){
        view.addSubview(dissmissButton)
        dissmissButton.translatesAutoresizingMaskIntoConstraints = false
        dissmissButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50).isActive = true
        dissmissButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        dissmissButton.setTitle("OK!", for: .normal)
        dissmissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    func setupData(){
        if let miprogreso1 = miprogreso1{
            nameLabel.text = miprogreso1.nombreExamen
        }else{
            nameLabel.text = "Nombre 1"
        }
    }
    func setupName(){
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: CircularProgress.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        nameLabel.textColor = .white
    }
    @objc func dismissAction(){
        self.dismiss(animated: true)
    }

}
