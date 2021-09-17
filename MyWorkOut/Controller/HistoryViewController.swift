//
//  HistoryViewController.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 13/9/21.
//

import UIKit

class HistoryViewController: UIViewController {
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(origin: .zero, size: CGSize.zero), style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderHeight = 30
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("History", comment: "History")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        setUpTableView()
    }
    

    private func setUpTableView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    

}

extension HistoryViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return UDManager.getUDSHistory().dateAndTime.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count = UDManager.getUDSHistory().dateAndTime.count
        for index in 0..<count{
            if section == index{
                return dateFormatter.string(from: UDManager.getUDSHistory().dateAndTime[index].dateOfPlay)
            }
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = UDManager.getUDSHistory().dateAndTime.count
        var rowCount = 0
        for index in 0..<count{
            if section == index{
                rowCount = UDManager.getUDSHistory().dateAndTime[section].timeOfPlay.count
                break
            }
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as! HistoryTableViewCell
    
        let exerciseName = Array(UDManager.getUDSHistory().dateAndTime[indexPath.section].timeOfPlay.keys)[indexPath.row]
        
        let time = Array(UDManager.getUDSHistory().dateAndTime[indexPath.section].timeOfPlay.values)[indexPath.row]
        cell.setUpTimeLabels(time: time)
        cell.setUpExerciseNameLabels(exerciseName: exerciseName.description)
        cell.setUpLabel()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    
