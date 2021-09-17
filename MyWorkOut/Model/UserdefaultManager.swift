//
//  UserdefaultManager.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 16/9/21.
//

import Foundation

class UDManager{
    
    static func setUDSExercise(){
        let encoder = JSONEncoder()
        guard let exerciseEncoded = try? encoder.encode(ExerciseManager.standard) else {
            return
        }
        UserDefaults.standard.set(exerciseEncoded, forKey: "Exercise")
    }
    
    static func setUDSExercise(newexerciseMG: (ExerciseManager) -> ExerciseManager){
        let newExercise = newexerciseMG(getUDSExercise())
        let encoder = JSONEncoder()
        guard let exerciseEncoded = try? encoder.encode(newExercise) else {
            return
        }
        UserDefaults.standard.set(exerciseEncoded, forKey: "Exercise")
    }
    
    static func setUDSHistory(){
        let encoder = JSONEncoder()
        guard let historyEncoded = try? encoder.encode(HistoryManager.standard) else {
            return
        }
        UserDefaults.standard.set(historyEncoded, forKey: "History")
    }
    
    static func setUDSHistory(newHistoryMG: (HistoryManager) -> (HistoryManager)){
        let newHistory = newHistoryMG(getUDSHistory())
        let encoder = JSONEncoder()
        guard let historyEncoded = try? encoder.encode(newHistory) else {
            return
        }
        UserDefaults.standard.set(historyEncoded, forKey: "History")
    }
    
    static func setUDSUser(){
        let encoder = JSONEncoder()
        guard let UserEncoded = try? encoder.encode(User.defaultUser) else {
            return
        }
        UserDefaults.standard.set(UserEncoded, forKey: "User")
    }
    
    static func setUDSUser(newUserMG: (User) -> User){
        let newUser = newUserMG(getUDSUser())
        let encoder = JSONEncoder()
        guard let UserEncoded = try? encoder.encode(newUser) else {
            return
        }
        UserDefaults.standard.set(UserEncoded, forKey: "User")
    }
    
    static func getUDSUser() -> User{
        let decoder = JSONDecoder()
        guard let savedUser = UserDefaults.standard.object(forKey: "User") as? Data,
              let dataUser = try? decoder.decode(User.self, from: savedUser)
        else {
            return User()
            }
        return dataUser
    }
    
    static func getUDSHistory() -> HistoryManager{
        let decoder = JSONDecoder()
        guard let savedHistory = UserDefaults.standard.object(forKey: "History") as? Data,
              let dataHistory = try? decoder.decode(HistoryManager.self, from: savedHistory)
        else {
            return HistoryManager()
            }
        return dataHistory
    }
    
    static func getUDSExercise() -> ExerciseManager{
        let decoder = JSONDecoder()
        guard let savedExercise = UserDefaults.standard.object(forKey: "Exercise") as? Data,
              let dataExercise  = try? decoder.decode(ExerciseManager.self , from: savedExercise)
        else {
            return ExerciseManager()
            }
        return dataExercise
    }
    
    static func setNewVideoContent(){
        UDManager.setUDSExercise { oldExercise in
            oldExercise.exercise[0].videoContent = URL(fileURLWithPath: Bundle.main.path(forResource: "Burpee", ofType: "mp4")!)
            oldExercise.exercise[1].videoContent = URL(fileURLWithPath: Bundle.main.path(forResource: "Lunges", ofType: "mp4")!)
            oldExercise.exercise[2].videoContent = URL(fileURLWithPath: Bundle.main.path(forResource: "ObiqueAndCore", ofType: "mp4")!)
            oldExercise.exercise[3].videoContent = URL(fileURLWithPath: Bundle.main.path(forResource: "Planks", ofType: "mp4")!)
            oldExercise.exercise[4].videoContent = URL(fileURLWithPath: Bundle.main.path(forResource: "Pushups", ofType: "mp4")!)
            oldExercise.exercise[5].videoContent = URL(fileURLWithPath: Bundle.main.path(forResource: "Squat", ofType: "mp4")!)
            return oldExercise
        }
    }
    
}
