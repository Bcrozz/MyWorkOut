//
//  MyWorkOutTabbarController.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 17/9/21.
//

import UIKit

class MyWorkOutTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
}

extension MyWorkOutTabbarController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard viewController is UINavigationController else {
            return
        }
        let pageVC = tabBarController.viewControllers![1] as! ExercisePageViewController
        let exerciseVC = pageVC.viewControllers![0] as! ExerciseViewController
        
        exerciseVC.player!.pause()
        exerciseVC.ourTimer.invalidate()
        exerciseVC.startAndStopButton.setTitle(NSLocalizedString("Start", comment: "Start"), for: .normal)
        

        UDManager.setUDSExercise { oldExerciseMG in
            oldExerciseMG.exercise[exerciseVC.exerciseVCIndex].setVideoCurrentTime(currentTime: exerciseVC.player!.currentTime().seconds)
            return oldExerciseMG
        }
        UDManager.setUDSUser { oldUser in
            oldUser.saveStateTime(step: exerciseVC.exerciseStep.exerciseName, time: exerciseVC.timerDisplay)
            oldUser.setCurrentPagingIndex(currentIndex: exerciseVC.exerciseVCIndex)
            return oldUser
        }
        
    }
}
