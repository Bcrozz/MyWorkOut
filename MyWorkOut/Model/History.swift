//
//  History.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 15/9/21.
//

import Foundation

class History: Codable {
    let dateOfPlay: Date
    var timeOfPlay: Array<TimeOfPlay>
    
    init(dateOfPlay: Date,timeOfPlay: Array<TimeOfPlay>) {
        self.dateOfPlay = dateOfPlay
        self.timeOfPlay = timeOfPlay
    }
    
}

class TimeOfPlay: Codable,Equatable {
    static func == (lhs: TimeOfPlay, rhs: TimeOfPlay) -> Bool {
        return lhs.exerciseName == rhs.exerciseName
    }
    
    private let exerciseName: Exercise
    private var playTime: Int
    
    init(exerciseName: Exercise,playTime: Int = 0) {
        self.exerciseName = exerciseName
        self.playTime = playTime
    }
    
    func updatePlayTime(time: Int){
        playTime = playTime + time
    }
    
    func getExerciseName() -> Exercise {
        return exerciseName
    }
    
    func getPlayTime() -> Int {
        return playTime
    }
    
}

class HistoryManager:Codable {
    
    static var standard = HistoryManager()
    
    var dateAndTime: Array<History> = []
    
    func dateCheck(for date:Date) -> Bool{
        
        if dateAndTime.count > 0{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            let count = dateAndTime.count
            if dateFormatter.string(from: dateAndTime[count - 1].dateOfPlay) == dateFormatter.string(from: date){
                return true
            }
            return false
        }else {
            return false
        }
    }
    
    func addHistory(date: Date,exerciseName: Exercise,playTime: Int){
        if !dateCheck(for: date){
            dateAndTime.append(History(dateOfPlay: date, timeOfPlay: [TimeOfPlay(exerciseName: exerciseName, playTime: playTime)]))
        }else {
            let count = dateAndTime.count
            if dateAndTime[count - 1].timeOfPlay.contains(where: { $0.getExerciseName() == exerciseName }){
                let indexAtExer = dateAndTime[count - 1].timeOfPlay.firstIndex(where: { $0.getExerciseName() == exerciseName })!
                dateAndTime[count - 1].timeOfPlay[indexAtExer].updatePlayTime(time: playTime)
            }else {
                dateAndTime[count - 1].timeOfPlay.append(TimeOfPlay(exerciseName: exerciseName, playTime: playTime))
            }
        }
    }
    
    func checkStepUnDone() -> Int?{
        let lastHistory = dateAndTime[dateAndTime.count - 1].timeOfPlay
        var stepName = [Exercise.Burpee:0,Exercise.Lunge:1,Exercise.ObiqueAndCore:2,Exercise.Plank:3,Exercise.Pushup:4,Exercise.Squat:5]
        for play in lastHistory{
            if stepName.contains(where: { $0.key == play.getExerciseName()}){
                stepName.removeValue(forKey: play.getExerciseName())
            }
        }
        
        return stepName.values.sorted().first
    }
}
