//
//  HistoryTableViewCell.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 16/9/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryCell"
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpTimeLabels(time:Int){
        let timeFormat = Date(timeIntervalSince1970: TimeInterval(time))
        let timeAttributedText = NSAttributedString(string: dateFormatter.string(from: timeFormat),
                                                    attributes: [ .font: UIFont(name: "Arial Bold", size: 20),
                                                                  .foregroundColor: UIColor.lightGray
                                                    ])
        timeLabel.attributedText = timeAttributedText
    }
    
    func setUpExerciseNameLabels(exerciseName: String){
        let exerciseAttributedText = NSAttributedString(string: exerciseName,
                                                    attributes: [ .font: UIFont(name: "Arial", size: 18),
                                                                  .foregroundColor: UIColor.black
                                                    ])
        exerciseNameLabel.attributedText = exerciseAttributedText
    }
    
    func setUpLabel() {
        addSubview(timeLabel)
        addSubview(exerciseNameLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            timeLabel.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.20),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: timeLabel.layoutMarginsGuide.trailingAnchor,constant: 15),
            exerciseNameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            exerciseNameLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            exerciseNameLabel.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor, multiplier: 0.50)
        ])
    }

}
