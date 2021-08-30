//
//  EvaluationCell.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 30/07/21.
//

import UIKit

// MARK: - EvaluationCell Class
final class EvaluationCell: UITableViewCell {
    // MARK: - Properties
    static let reuseId = "evaluationCell"
    private weak var containerView: UIView?
    private weak var evaluationTitleLabel: UILabel?
    
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
        let containerView = UIView()
        containerView.backgroundColor = .systemBackground
        containerView.cardStyle()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        self.containerView = containerView
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            containerView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
