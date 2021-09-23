//
//  OptionCell.swift
//  UpperQuizz
//
//  Created by Rodrigo Francisco on 21/09/21.
//

import UIKit

// MARK: - OptionCell Class
final class OptionCell: UITableViewCell {
    // MARK: - Identifier
    static let reuseId = "optionCell"
    
    public var option: Option? {
        didSet {
            updateOptionText()
        }
    }
    public var wasSelected: Bool?
    
    private weak var containerView: UIView?
    private weak var optionText: UILabel?
    
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        guard let containerView = containerView else { return }
        if selected {
            containerView.backgroundColor = Constants.primaryColor
            optionText?.textColor = .white
        } else {
            containerView.backgroundColor = .white
            optionText?.textColor = .black
        }
        print("Executed function setSelected")
        
        guard let wasSelected = wasSelected else { return }
        if wasSelected {
            containerView.backgroundColor = Constants.primaryColor
            optionText?.textColor = .white
            print("DEBUG: Making container blue")
        }
    }
    
    // MARK: - Helpers
    func updateOptionText() {
        guard let optionText = optionText, let option = option else { return }
        optionText.text = option.texto_opcion
    }
    
    func configureCellLayout() { 
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.cardStyle()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        self.containerView = containerView
        
        let optionText = UILabel()
        optionText.text = "Opción"
        optionText.numberOfLines = 0
        optionText.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(optionText)
        self.optionText = optionText
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            optionText.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            optionText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            optionText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            optionText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15)
        ])
    }
}
