//
//  ExerciseStep.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 13/9/21.
//

import Foundation
import AVFoundation

class ExerciseStep:Codable,Equatable {
    
    static func == (lhs: ExerciseStep, rhs: ExerciseStep) -> Bool {
        return lhs.exerciseName == rhs.exerciseName
    }
    
    let exerciseName:Exercise
    var videoContent:URL
    var rateIndex:Int = 0
    var videoCurrentTimer:Double = 0
    
    init(exerciseName: Exercise,videoContent: URL) {
        self.exerciseName = exerciseName
        self.videoContent = videoContent
    }
    
    func setVideoCurrentTime(currentTime:Double){
        videoCurrentTimer = currentTime
    }
    
    func getVideoDuration() -> Double{
        let asset = AVURLAsset(url: videoContent)
        let duration = asset.duration
        return duration.seconds
    }
    
}


class ExerciseManager:Codable {
    
    static var standard = ExerciseManager()
    
    var exercise:Array<ExerciseStep> = [
        ExerciseStep(exerciseName: Exercise.Burpee, videoContent: URL(fileURLWithPath: Bundle.main.path(forResource: "Burpee", ofType: "mp4")!)),
        ExerciseStep(exerciseName: Exercise.Lunge, videoContent: URL(fileURLWithPath: Bundle.main.path(forResource: "Lunges", ofType: "mp4")!)),
        ExerciseStep(exerciseName: Exercise.ObiqueAndCore, videoContent: URL(fileURLWithPath: Bundle.main.path(forResource: "ObiqueAndCore", ofType: "mp4")!)),
        ExerciseStep(exerciseName: Exercise.Plank, videoContent: URL(fileURLWithPath: Bundle.main.path(forResource: "Planks", ofType: "mp4")!)),
        ExerciseStep(exerciseName: Exercise.Pushup, videoContent: URL(fileURLWithPath: Bundle.main.path(forResource: "Pushups", ofType: "mp4")!)),
        ExerciseStep(exerciseName: Exercise.Squat, videoContent: URL(fileURLWithPath: Bundle.main.path(forResource: "Squat", ofType: "mp4")!))
    ]
    
    
}

enum Exercise: String,Codable {
    case Burpee = "Burpee"
    case Lunge = "Lunges"
    case ObiqueAndCore = "ObiqueAndCore"
    case Plank = "Plank"
    case Pushup = "Pushup"
    case Squat = "Squat"
}

extension Exercise {
    
    var description: String {
        get{
            switch self {
            case .Burpee:
                return NSLocalizedString("Burpee", comment: "Burpee")
            case .Lunge:
                return NSLocalizedString("Lunges", comment: "Lunges")
            case .ObiqueAndCore:
                return NSLocalizedString("ObiqueAndCore", comment: "ObiqueAndCore")
            case .Plank:
                return NSLocalizedString("Plank", comment: "Plank")
            case .Pushup:
                return NSLocalizedString("Pushup", comment: "Pushup")
            case .Squat:
                return NSLocalizedString("Squat", comment: "Squat")
            }
        }
    }
}
