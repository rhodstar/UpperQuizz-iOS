//
//  RemindersController.swift
//  UpperQuizz
//
//  Created by Rodrigo Francisco Pablo on 20/07/21.
//

import UIKit

// MARK: - RemindersController Class
final class RemindersController: UITableViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Helpers
    func configureViewController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = Constants.reminderTitle
    }
    
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backgroundColor
        self.tableView.register(ReminderCell.self, forCellReuseIdentifier: ReminderCell.reuseId)
    }
}

// MARK: - UICollectionViewDataSource
extension RemindersController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.reuseId, for: indexPath) as! ReminderCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ReminderCell.cellHeight + 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Present questions for specific evaluation
        print("DEBUG: Implement functionality here")
    }
}
