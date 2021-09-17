//
//  History.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 15/9/21.
//

import Foundation

class History: Codable {
    let dateOfPlay: Date
    var timeOfPlay: Dictionary<Exercise, Int>
    
    init(dateOfPlay: Date,timeOfPlay: [Exercise:Int]) {
        self.dateOfPlay = dateOfPlay
        self.timeOfPlay = timeOfPlay
    }
    
}

class HistoryManager:Codable {
    
    static var standard = HistoryManager()
    
    var dateAndTime: Array<History> = []
    
    func dateCheck(for date:Date) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        
        if dateAndTime.count > 0{
            let count = dateAndTime.count
            if dateFormatter.string(from: dateAndTime[count - 1].dateOfPlay) == dateFormatter.string(from: date){
                return true
            }
            return false
        }else {
            return false
        }
    }
    
    func addHistory(date: Date,stepName:Exercise,playTime:Int){
        if !dateCheck(for: date){
            dateAndTime.append(History(dateOfPlay: date, timeOfPlay: [stepName:playTime]))
        }else {
            let count = dateAndTime.count
            if let lastPlayTime = dateAndTime[count - 1].timeOfPlay[stepName] {
                dateAndTime[count - 1].timeOfPlay.updateValue((playTime + lastPlayTime), forKey: stepName)
            }
            else{
                dateAndTime[count - 1].timeOfPlay.updateValue((playTime), forKey: stepName)
            }
        }
    }
    
    
    func checkStepUnDone() -> Int?{
        let lastHistory = dateAndTime[dateAndTime.count - 1]
        var stepName = [Exercise.Burpee:0,Exercise.Lunge:1,Exercise.ObiqueAndCore:2,Exercise.Plank:3,Exercise.Pushup:4,Exercise.Squat:5]
        for stepKey in lastHistory.timeOfPlay.keys{
            stepName.removeValue(forKey: stepKey)
        }
        
        return stepName.values.sorted().first
    }
}
