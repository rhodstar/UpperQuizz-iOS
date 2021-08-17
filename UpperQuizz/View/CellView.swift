//
//  CellView.swift
//  UpperQuizz
//
//  Created by Hernán Galileo Cabrera Garibaldi on 13/08/21.
//

import UIKit

class CellView: UITableViewCell {
    let iconView = UIImageView(image: UIImage(systemName: "archivebox.fill"))
    var nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let horizontalProgressBar = HorizontalProgressBar()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:: ) has not been implemented")
    }
    func setupView(){
        setupIconView()
        setupNameLabel()
        setupDescriptionLabel()
        setupHorizontalProgress()
    }
    func setupIconView(){
        addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func setupNameLabel(){
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
    }
    func setupDescriptionLabel(){
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        descriptionLabel.font = UIFont(name: "Verdana", size: 14)
    }
    func setupHorizontalProgress(){
        addSubview(horizontalProgressBar)
        horizontalProgressBar.translatesAutoresizingMaskIntoConstraints = false
        horizontalProgressBar.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        horizontalProgressBar.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 10).isActive = true
        horizontalProgressBar.trailingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: -10).isActive = true
        horizontalProgressBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        horizontalProgressBar.heightAnchor.constraint(equalToConstant: 7).isActive = true
    }
}
