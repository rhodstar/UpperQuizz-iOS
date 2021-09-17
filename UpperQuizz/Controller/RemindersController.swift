//
//  RemindersController.swift
//  UpperQuizz
//
//  Created by Rodrigo Francisco Pablo on 20/07/21.
//

import UIKit
import SafariServices

// MARK: - RemindersController Class
final class RemindersController: UITableViewController {
    
    var reminders: [Reminder]? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        loadReminders()
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
    
    func loadReminders() {
        self.reminders = [
            Reminder(reminderTitle: "Primera vuelta UNAM", announcementDate: "14 de febrero de 2022", examenDate: "18 de marzo de 2022", imageThumbnail: "unam", url: "https://www.dgae.unam.mx/admision_licenciatura"),
            Reminder(reminderTitle: "Primera vuelta IPN", announcementDate: "14 de mayo de 2022", examenDate: "11 de junio de 2022", imageThumbnail: "ipn", url: "https://admision.ipn.mx/se/convocatoria/index.html"),
            Reminder(reminderTitle: "Primera vuelta UAM", announcementDate: "04 de junio de 2022", examenDate: "26 de julio de 2022", imageThumbnail: "uam", url: "https://www.admision.uam.mx"),
            Reminder(reminderTitle: "Primera vuelta BUAP", announcementDate: "06 de abril de 2022", examenDate: "15 de julio de 2022", imageThumbnail: "buap", url: "https://admision.buap.mx"),
        ]
    }
}

// MARK: - UICollectionViewDataSource
extension RemindersController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.reuseId, for: indexPath) as! ReminderCell
        cell.reminder = reminders?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight + 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = reminders?[indexPath.row].url ?? Constants.backupURL
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
    }
}
