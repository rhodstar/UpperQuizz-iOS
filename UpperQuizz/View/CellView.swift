//
//  CellView.swift
//  UpperQuizz
//
//  Created by Hernán Galileo Cabrera Garibaldi on 13/08/21.
//

import UIKit

class CellView: UITableViewCell {
    var safeArea: UILayoutGuide!
    let circularProgress = CircularProgressView2()
    var nameLabel = UILabel()
    let gameSeriesLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:: ) has not been implemented")
    }
    func setupView(){
        safeArea = layoutMarginsGuide
        setupImageView()
        setupNameLabel()
        setupGameSeriesLabel()
        
    }
    func setupImageView(){
        addSubview(circularProgress)
        circularProgress.translatesAutoresizingMaskIntoConstraints = false
        circularProgress.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        circularProgress.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        circularProgress.widthAnchor.constraint(equalToConstant: 40).isActive = true
        circularProgress.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        imageIV.backgroundColor = .red
    }
    func setupNameLabel(){
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leadingAnchor.constraint(equalTo: circularProgress.trailingAnchor, constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
    }
    func setupGameSeriesLabel(){
        addSubview(gameSeriesLabel)
        
        gameSeriesLabel.translatesAutoresizingMaskIntoConstraints = false
        gameSeriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        gameSeriesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        gameSeriesLabel.font = UIFont(name: "Verdana", size: 16)
    }
}
