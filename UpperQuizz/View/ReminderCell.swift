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
    
    // MARK: - Containers
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.cardStyle(radius: 10.0)
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerCoverImage = RoundedUIView()
        containerCoverImage.customCorners = [.topLeft, .bottomLeft]
        
        containerView.addSubview(containerCoverImage)
        containerCoverImage.anchor(top: containerView.topAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor,width: 100)
        
        containerCoverImage.addSubview(coverImage)
        coverImage.anchor(top:containerCoverImage.topAnchor,bottom: containerCoverImage.bottomAnchor, leading: containerCoverImage.leadingAnchor, trailing: containerCoverImage.trailingAnchor)
        
        containerView.addSubview(itemTitleLabel)
        itemTitleLabel.anchor(top: containerView.topAnchor, paddingTop: 8, leading: containerCoverImage.trailingAnchor, leadingPadding: 10)
        
        containerView.addSubview(announcementLabel)
        announcementLabel.anchor(top:itemTitleLabel.topAnchor, paddingTop: 30, leading: containerCoverImage.trailingAnchor, leadingPadding: 10, width: 100)
        
        containerView.addSubview(examLabel)
        examLabel.anchor(top:announcementLabel.topAnchor, paddingTop: 50, leading: containerCoverImage.trailingAnchor, leadingPadding: 10, width: 100)
        
        containerView.addSubview(announcementDateLabel)
        announcementDateLabel.anchor(top:itemTitleLabel.topAnchor, paddingTop: 30, trailing: containerView.trailingAnchor, trailingPadding: 5, width: 130)
        
        containerView.addSubview(examDateLabel)
        examDateLabel.anchor(top:announcementDateLabel.topAnchor, paddingTop: 50, trailing: containerView.trailingAnchor, trailingPadding: 5, width: 130)
        
        containerView.addSubview(seeMoreLabel)
        seeMoreLabel.anchor(bottom: containerView.bottomAnchor, paddingBottom: -10, trailing: containerView.trailingAnchor, trailingPadding: 15)

        return containerView
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
        label.text = Constants.reminderItemTitle
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let announcementLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = Constants.reminderAnnounceText
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let announcementDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "14 de febrero de 2022"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let examLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = Constants.reminderExamDateText
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let examDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "18 de marzo de 2022"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let seeMoreLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.reminderSeeMore
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemBlue
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
                             trailing: trailingAnchor, trailingPadding: 15,
                             height: Constants.cellHeight)
        
    }
}

