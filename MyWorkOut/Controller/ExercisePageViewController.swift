//
//  ExercisePageViewController.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 13/9/21.
//

import UIKit

class ExercisePageViewController: UIPageViewController {
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = UDManager.getUDSExercise().exercise.count
        pageControl.currentPageIndicatorTintColor = .systemPink
        pageControl.pageIndicatorTintColor = .gray
        pageControl.backgroundStyle = .automatic
        pageControl.currentPage = UDManager.getUDSUser().getCurrentPagingIndex()
        pageControl.addTarget(self, action: #selector(didTapPageControl), for: .touchUpInside)
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Exercise", comment: "Exercise")
        dataSource = self
        delegate = self
        let vc = ExerciseViewController(exerciseStep: UDManager.getUDSExercise().exercise[UDManager.getUDSUser().getCurrentPagingIndex()], indexVC: UDManager.getUDSUser().getCurrentPagingIndex())
        setViewControllers([vc], direction: .forward, animated: false)
        setUpPageControl()
    }
    
    private func setUpPageControl(){
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.widthAnchor.constraint(equalTo: pageControl.heightAnchor, multiplier: 4)
        ])
    }
    
    @objc private func didTapPageControl(_ sender: UIPageControl){
        let currentVC = viewControllers![0] as! ExerciseViewController
        let currentIndex = currentVC.exerciseVCIndex
        currentVC.player?.pause()
        currentVC.startAndStopButton.setTitle(NSLocalizedString("Start", comment: "Start"), for: .normal)
        
        UDManager.setUDSExercise { oldExerciseMG in
            oldExerciseMG.exercise[currentIndex].setVideoCurrentTime(currentTime: currentVC.player!.currentTime().seconds)
            return oldExerciseMG
        }
        UDManager.setUDSUser { oldUser in
            oldUser.setCurrentPagingIndex(currentIndex: sender.currentPage)
            oldUser.saveStateTime(step: currentVC.exerciseStep.exerciseName, time: currentVC.timerDisplay)
            return oldUser
        }
        
        if sender.currentPage > currentIndex{
            let newVC = ExerciseViewController(exerciseStep: UDManager.getUDSExercise().exercise[sender.currentPage], indexVC: sender.currentPage)
            setViewControllers([newVC], direction: .forward, animated: true)
        }
        else if sender.currentPage < currentIndex{
            let newVC = ExerciseViewController(exerciseStep: UDManager.getUDSExercise().exercise[sender.currentPage], indexVC: sender.currentPage)
            setViewControllers([newVC], direction: .reverse, animated: true)
        }
        else {
            return
        }
    }
    
    func goToUnDonePage(for index:Int){
       let vc = ExerciseViewController(exerciseStep: UDManager.getUDSExercise().exercise[index], indexVC: index)
        pageControl.currentPage = index
        setViewControllers([vc], direction: .reverse, animated: true)
    }
    
    func goToNextPage(for index:Int){
        let nextPageIndex = index + 1
        if nextPageIndex < UDManager.getUDSExercise().exercise.count {
            let vc = ExerciseViewController(exerciseStep: UDManager.getUDSExercise().exercise[nextPageIndex], indexVC: nextPageIndex)
            pageControl.currentPage = nextPageIndex
            self.setViewControllers([vc], direction: .forward, animated: true)
        }
    }


}

extension ExercisePageViewController: UIPageViewControllerDataSource,UIImagePickerControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let BeforePageIndex = (viewController as! ExerciseViewController).exerciseVCIndex - 1
        
        if (BeforePageIndex) < 0 {
            return nil
        }
        
       let beforeVC = ExerciseViewController(exerciseStep: UDManager.getUDSExercise().exercise[BeforePageIndex], indexVC: BeforePageIndex)
        
        return beforeVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let afterPageIndex = (viewController as! ExerciseViewController).exerciseVCIndex + 1
                
        if (afterPageIndex) >= UDManager.getUDSExercise().exercise.count {
            return nil
        }
        
        let afterVC = ExerciseViewController(exerciseStep: UDManager.getUDSExercise().exercise[afterPageIndex], indexVC: afterPageIndex)
        
        return afterVC
    }
    
    
}

extension ExercisePageViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //initialize variable
        let currentVCIndex = (pageViewController.viewControllers![0] as! ExerciseViewController).exerciseVCIndex
        let previousVC = previousViewControllers[0] as! ExerciseViewController
        let previousVCIndex = previousVC.exerciseVCIndex
        //initialize variable
        //set currentPageIndex of PageControl
        pageControl.currentPage = currentVCIndex
        //set currentPageIndex of PageControl
        //pause video and stop timer
        previousVC.player?.pause()
        previousVC.ourTimer.invalidate()
        previousVC.startAndStopButton.setTitle(NSLocalizedString("Start", comment: "Start"), for: .normal)
        //pause video and stop timer
        //save video current time, save user video time state and set user currentpageindex
        
        UDManager.setUDSExercise { oldExerciseMG in
            oldExerciseMG.exercise[previousVCIndex].setVideoCurrentTime(currentTime: previousVC.player!.currentTime().seconds)
            return oldExerciseMG
        }
        UDManager.setUDSUser { oldUser in
            oldUser.saveStateTime(step: previousVC.exerciseStep.exerciseName, time: previousVC.timerDisplay)
            oldUser.setCurrentPagingIndex(currentIndex: currentVCIndex)
            return oldUser
        }
        
    
        
        //save state video,timer and User state timer
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        //set currentPageIndex of PageControl
        let vcIndex = (pendingViewControllers[0] as! ExerciseViewController).exerciseVCIndex
        pageControl.currentPage = vcIndex
    }
    
    
}


