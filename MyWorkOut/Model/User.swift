//
//  User.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 14/9/21.
//

import Foundation

class User: Codable {
    
    static var defaultUser:User = User()
    
    var burpeePlayTime:Int = 0
    var lungesPlayTime:Int = 0
    var ObiqueAndCorePlayTime:Int = 0
    var planksPlayTimer:Int = 0
    var pushupsPlayTimer:Int = 0
    var SquatsPlayTimer:Int = 0
    private var currentPagingIndex:Int = 0
    
    func getCurrentPagingIndex() -> Int{
        return currentPagingIndex
    }
    
    func setCurrentPagingIndex(currentIndex:Int) {
        currentPagingIndex = currentIndex
    }
    
    func getStateTime(step:Exercise) -> Int{
        switch step {
        case .Burpee:
            return burpeePlayTime
        case .Lunge:
            return lungesPlayTime
        case .ObiqueAndCore:
            return ObiqueAndCorePlayTime
        case .Plank:
            return planksPlayTimer
        case .Pushup:
            return pushupsPlayTimer
        case .Squat:
            return SquatsPlayTimer
        }
    }
    
    func saveStateTime(step:Exercise,time:Int) {
        switch step {
        case .Burpee:
            burpeePlayTime = time
        case .Lunge:
            lungesPlayTime = time
        case .ObiqueAndCore:
            ObiqueAndCorePlayTime = time
        case .Plank:
            planksPlayTimer = time
        case .Pushup:
            pushupsPlayTimer = time
        case .Squat:
            SquatsPlayTimer = time
        }
    }
    
    func resetStateTime(step:Exercise){
        switch step {
        case .Burpee:
            burpeePlayTime = 0
        case .Lunge:
            lungesPlayTime = 0
        case .ObiqueAndCore:
            ObiqueAndCorePlayTime = 0
        case .Plank:
            planksPlayTimer = 0
        case .Pushup:
            pushupsPlayTimer = 0
        case .Squat:
            SquatsPlayTimer = 0
        }
    }
    
}
