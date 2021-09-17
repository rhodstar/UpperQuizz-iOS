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
    var viewModel: EvaluationViewModel? {
        didSet { configure() }
    }
    
    static let reuseId = "evaluationCell"
    private weak var containerView: UIView?
    private weak var statusView: UIView?
    private weak var evaluationTitleLabel: UILabel?
    private weak var evaluationSubtitleLabel: UILabel?
    private weak var dynamicView: UIView?
    private weak var startImageView: UIImageView?
    private weak var completionPercentageLabel: UILabel?
    private weak var circularProgressBarView: CircularProgressBarView?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContainerView()
        configureContentCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    public func configure() {
        guard let viewModel = viewModel else { return }
        evaluationTitleLabel?.text = viewModel.evaluation.nombreExamen
        startImageView?.isHidden = !viewModel.isInitialEvaluation
        circularProgressBarView?.isHidden = viewModel.isInitialEvaluation
        circularProgressBarView?.progressAnimation(progressPercentage: viewModel.completionPercentage)
        circularProgressBarView?.progressLayer.strokeColor = viewModel.colorByStatus.cgColor
        evaluationSubtitleLabel?.text = viewModel.subtitleMessage
        evaluationSubtitleLabel?.textColor = viewModel.colorByStatus
        statusView?.backgroundColor = viewModel.colorByStatus
        completionPercentageLabel?.text = viewModel.completePercentage
        completionPercentageLabel?.textColor = viewModel.colorByStatus
        completionPercentageLabel?.isHidden = viewModel.isInitialEvaluation
    }
    
    private func configureContainerView() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.cardStyle()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        self.containerView = containerView
        backgroundColor = .clear
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            containerView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func configureContentCell() {
        guard let containerView = containerView else { return }
        let statusView: UIView = UIView()
        statusView.backgroundColor = Constants.secondaryColor
        statusView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(statusView)
        self.statusView = statusView
        
        let evaluationTitleLabel: UILabel = UILabel()
        evaluationTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        evaluationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(evaluationTitleLabel)
        self.evaluationTitleLabel = evaluationTitleLabel
        
        let evaluationSubtitleLabel: UILabel = UILabel()
        evaluationSubtitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        evaluationSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(evaluationSubtitleLabel)
        self.evaluationSubtitleLabel = evaluationSubtitleLabel
        
        let dynamicView: UIView = UIView()
        dynamicView.backgroundColor = .clear
        dynamicView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dynamicView)
        self.dynamicView = dynamicView
        
        let startImageView = UIImageView(image: UIImage(named: "chevron.right"))
        startImageView.tintColor = Constants.primaryColor
        startImageView.translatesAutoresizingMaskIntoConstraints = false
        dynamicView.addSubview(startImageView)
        self.startImageView = startImageView
        
        let completionPercentageLabel = UILabel()
        completionPercentageLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        completionPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        dynamicView.addSubview(completionPercentageLabel)
        self.completionPercentageLabel = completionPercentageLabel
        
        let circularProgressBarView = CircularProgressBarView(frame: .zero)
        circularProgressBarView.translatesAutoresizingMaskIntoConstraints = false
        dynamicView.addSubview(circularProgressBarView)
        self.circularProgressBarView = circularProgressBarView
        
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            statusView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            statusView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            statusView.widthAnchor.constraint(equalToConstant: 7),
            
            dynamicView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            dynamicView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            dynamicView.widthAnchor.constraint(equalToConstant: 50),
            dynamicView.heightAnchor.constraint(equalToConstant: 50),
            
            evaluationTitleLabel.topAnchor.constraint(equalTo: statusView.topAnchor),
            evaluationTitleLabel.leadingAnchor.constraint(equalTo: statusView.leadingAnchor, constant: 20),
            evaluationTitleLabel.trailingAnchor.constraint(equalTo: dynamicView.leadingAnchor, constant: -15),
            evaluationTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            evaluationSubtitleLabel.bottomAnchor.constraint(equalTo: statusView.bottomAnchor),
            evaluationSubtitleLabel.leadingAnchor.constraint(equalTo: evaluationTitleLabel.leadingAnchor),
            evaluationSubtitleLabel.trailingAnchor.constraint(equalTo: evaluationSubtitleLabel.trailingAnchor),
            
            startImageView.centerXAnchor.constraint(equalTo: dynamicView.centerXAnchor),
            startImageView.centerYAnchor.constraint(equalTo: dynamicView.centerYAnchor),
            startImageView.widthAnchor.constraint(equalToConstant: 15),
            startImageView.heightAnchor.constraint(equalToConstant: 30),
            
            completionPercentageLabel.centerYAnchor.constraint(equalTo: dynamicView.centerYAnchor),
            completionPercentageLabel.centerXAnchor.constraint(equalTo: dynamicView.centerXAnchor),
            
            circularProgressBarView.centerYAnchor.constraint(equalTo: dynamicView.centerYAnchor),
            circularProgressBarView.centerXAnchor.constraint(equalTo: dynamicView.centerXAnchor)
        ])
    }
}
