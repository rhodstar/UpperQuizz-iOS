//
//  EvaluationCell.swift
//  UpperQuizz
//
//  Created by Rodrigo Francisco Pablo on 01/09/21.
//

import UIKit

// MARK: - ReminderCell Class
final class ReminderCell: UITableViewCell {
    // MARK: - Identifier
    static let reuseId = "reminderCell"
    
    private weak var reminderTitleLabel: UILabel?
    
//    private let cardHeight: CGFloat = 2500
    
    // MARK: - Containers
    private lazy var containerView: UIView = {
        let containerView = RoundedUIView()
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(coverImage)
        coverImage.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, width: 90)
        
        containerView.addSubview(textLabelsContainer)
        textLabelsContainer.anchor(top:containerView.topAnchor,bottom: containerView.bottomAnchor, leading: coverImage.trailingAnchor,trailing: containerView.trailingAnchor)

        return containerView
    }()
    

    private lazy var textLabelsContainer: UIView = {
        let tvContainer = UIView()
        tvContainer.backgroundColor = .lightGray
        
        tvContainer.addSubview(itemTitleLabel)
        itemTitleLabel.anchor(top: tvContainer.topAnchor, paddingTop: 8)
        itemTitleLabel.centerX(inView: tvContainer)
        
        tvContainer.addSubview(announcementLabel)
        announcementLabel.anchor(top:itemTitleLabel.topAnchor, paddingTop: 20, leading: tvContainer.leadingAnchor, leadingPadding: 10, width: 100)
        
//        tvContainer.addSubview(examLabel)
//        examLabel.anchor(top:announcementLabel.topAnchor, paddingTop: 20, leading: tvContainer.leadingAnchor, leadingPadding: 10, width: 100)
        
        return tvContainer
    }()
    
    // MARK: - Properties
    private let coverImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "unam")
        image.clipsToBounds = true
        return image
    }()
    
    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Primera vuelta UNAM"
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    
    private let announcementLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Fecha de la convocatoria"
        return label
    }()
    
    private let announcementDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "14 de febrero de 2022"
        return label
    }()
    
    private let examLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Fecha del examen"
        return label
    }()
    
    private let examDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "18 de marzo de 2022"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellLayout()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureCellLayout() {

        addSubview(containerView)
        containerView.anchor(top:topAnchor, paddingTop: 10,
                             leading: leadingAnchor, leadingPadding: 15,
                             trailing: trailingAnchor, trailingPadding: -15,
                             height: 70)
        
    }
}

