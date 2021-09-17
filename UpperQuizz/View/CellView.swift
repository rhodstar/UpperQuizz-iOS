//
//  CellView.swift
//  UpperQuizz
//
//  Created by Hernán Galileo Cabrera Garibaldi on 13/08/21.
//

import UIKit

class CellView: UITableViewCell {
    let containerView: UIView = {
       let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
//        container.backgroundColor = .blue
        return container
    }()
    var iconView = UIImageView(image: UIImage(systemName: "archivebox.fill"))
    var nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let horizontalProgressBar = HorizontalProgressBar()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        backgroundColor = .clear
        selectionStyle = .none
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:: ) has not been implemented")
    }
    func setupView(){
        setupContainerView()
        setupIconView()
        setupNameLabel()
        setupDescriptionLabel()
        setupHorizontalProgress()
    }
    func setupContainerView() {
        addSubview(containerView)
        containerView.cardStyle()
        containerView.backgroundColor = .white
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    func setupIconView(){
        containerView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        iconView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func setupNameLabel(){
        containerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 5).isActive = true
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
    }
    func setupDescriptionLabel(){
        containerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        descriptionLabel.font = UIFont(name: "Verdana", size: 14)
    }
    func setupHorizontalProgress(){
        containerView.addSubview(horizontalProgressBar)
        horizontalProgressBar.translatesAutoresizingMaskIntoConstraints = false
        horizontalProgressBar.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        horizontalProgressBar.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        horizontalProgressBar.trailingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: -10).isActive = true
//        horizontalProgressBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        horizontalProgressBar.heightAnchor.constraint(equalToConstant: 7).isActive = true
    }
}
