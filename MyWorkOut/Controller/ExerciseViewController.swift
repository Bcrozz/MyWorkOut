//
//  ExerciseViewController.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 9/9/21.
//

import UIKit
import AVFoundation
import AVKit
import Foundation

class ExerciseViewController: UIViewController {
    
    let exerciseVCIndex: Int
    let exerciseStep: ExerciseStep
    var timerDisplay:Int = 0
    var ourTimer = Timer()
    var countDownTimer = -3
    
    init(exerciseStep: ExerciseStep,indexVC: Int) {
        self.exerciseStep = exerciseStep
        self.exerciseVCIndex = indexVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        return dateFormatter
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial Bold", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var videoVC: AVPlayerViewController = {
        let videoVC = AVPlayerViewController()
        videoVC.view.translatesAutoresizingMaskIntoConstraints = false
        videoVC.videoGravity = .resizeAspect
        videoVC.view.backgroundColor = .systemPink
        videoVC.showsPlaybackControls = false
        return videoVC
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(DidTappedStartORDone),
                         for: .touchUpInside)
        button.setTitle(NSLocalizedString("Start", comment: "Start"), for: .normal)
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Done", comment: "Done"), for: .normal)
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    public let startAndStopButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Stop", comment: "Stop"), for: .normal)
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self,
                         action: #selector(DidTappedStartORDone),
                         for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "\(0)",
                                                  attributes: [
                                                    .font:UIFont(name: "Arial Bold", size: 75),
                                                    .foregroundColor:UIColor.black
                                                  ])
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let countDownTimerLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "\(3)",
                                                  attributes: [
                                                    .font:UIFont(name: "Arial Bold", size: 75),
                                                    .foregroundColor:UIColor.black
                                                  ])
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let rateView = RateView()
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeaderLabel()
        setUpVideo()
        setUpStartAndDoneButton()
        setUpTimerLabel()
        rateView.delegate = self
        rateView.setRate(rate: exerciseStep.rateIndex)
        setUpRateView()
    }
    
    private func setUpHeaderLabel(){
        headerLabel.text = exerciseStep.exerciseName.description
        view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.widthAnchor.constraint(equalToConstant: 300),
            headerLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func setUpVideo(){
        player = AVPlayer(url: exerciseStep.videoContent)
        videoVC.player = player
        player?.seek(to: CMTime(seconds: exerciseStep.videoCurrentTimer,
                                preferredTimescale: 1))
        view.addSubview(videoVC.view)
        NSLayoutConstraint.activate([
            videoVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 120),
            videoVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoVC.view.heightAnchor.constraint(equalTo: videoVC.view.widthAnchor, multiplier: 1.5/3.0)
        ])
    }
    
    private func setUpStartAndDoneButton(){
        view.addSubview(startButton)
        view.addSubview(doneButton)
        view.addSubview(startAndStopButton)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: videoVC.view.bottomAnchor, constant: 30),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            startButton.widthAnchor.constraint(equalToConstant: 80),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.topAnchor.constraint(equalTo: videoVC.view.bottomAnchor, constant: 30),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            doneButton.widthAnchor.constraint(equalToConstant: 80),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            startAndStopButton.topAnchor.constraint(equalTo: videoVC.view.bottomAnchor, constant: 30),
            startAndStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            startAndStopButton.widthAnchor.constraint(equalToConstant: 80),
            startAndStopButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    private func setUpTimerLabel(){
        timerDisplay = UDManager.getUDSUser().getStateTime(step: exerciseStep.exerciseName)
        timerLabel.text = "\(UDManager.getUDSUser().getStateTime(step: exerciseStep.exerciseName))"
        view.addSubview(timerLabel)
        view.addSubview(countDownTimerLabel)
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: videoVC.view.bottomAnchor, constant: 110),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.widthAnchor.constraint(equalToConstant: 200),
            timerLabel.heightAnchor.constraint(equalToConstant: 100),
            countDownTimerLabel.topAnchor.constraint(equalTo: videoVC.view.bottomAnchor, constant: 110),
            countDownTimerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownTimerLabel.widthAnchor.constraint(equalToConstant: 200),
            countDownTimerLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setUpRateView(){
        view.addSubview(rateView)
        NSLayoutConstraint.activate([
            rateView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 40),
            rateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rateView.widthAnchor.constraint(equalTo: rateView.heightAnchor, multiplier: 5),
            rateView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc private func DidTappedStartORDone(_ sender:UIButton){
        if sender.tag == 0{
            prepareForCountDownAndVideoPlay()
        }
        else if sender.tag == 1{
            editStartButtonAndVideoState(sender)
        }
        else {
            saveHistoryAndUserState()
        }
    }
    
    private func prepareForCountDownAndVideoPlay(){
        startButton.removeTarget(nil,
                                 action: nil,
                                 for: .allEvents)
        countDownTimerLabel.isHidden = false
        ourTimer = Timer.scheduledTimer(timeInterval: 1,
                                        target: self,
                                        selector: #selector(countDownFor3),
                                        userInfo: nil,
                                        repeats: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            for subview in strongSelf.view.subviews {
                if subview is UIImageView{
                    subview.removeFromSuperview()
                    break
                }
            }
            strongSelf.startButton.isHidden = true
            strongSelf.startAndStopButton.isHidden = false
            strongSelf.timerLabel.isHidden = false
            strongSelf.doneButton.setTitleColor(.systemBlue, for: .normal)
            strongSelf.doneButton.addTarget(self,
                                            action: #selector(strongSelf.DidTappedStartORDone),
                                            for: .touchUpInside)
            strongSelf.player?.play()
            strongSelf.ourTimer = Timer.scheduledTimer(timeInterval: 1,
                                                       target: strongSelf,
                                                       selector: #selector(strongSelf.countTimer),
                                                       userInfo: nil,
                                                       repeats: true)
        }
    }
    
    private func editStartButtonAndVideoState(_ sender:UIButton){
        if sender.currentTitle == NSLocalizedString("Start", comment: "Start"){
            if player!.currentTime().seconds >= exerciseStep.getVideoDuration() {
                exerciseStep.setVideoCurrentTime(currentTime: 0)
                player?.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
            }
            sender.setTitle(NSLocalizedString("Stop", comment: "Stop"), for: .normal)
            player?.play()
            ourTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTimer), userInfo: nil, repeats: true)
        }else {
            sender.setTitle(NSLocalizedString("Start", comment: "Start"), for: .normal)
            player?.pause()
            ourTimer.invalidate()
        }
    }
    
    private func saveHistoryAndUserState(){
        let pageVC = parent as! ExercisePageViewController
        let navigationOfHistoryVC = tabBarController?.viewControllers?[2] as! UINavigationController
        let historyVC = navigationOfHistoryVC.viewControllers[0] as! HistoryViewController
        
        player?.pause()
        ourTimer.invalidate()
        exerciseStep.setVideoCurrentTime(currentTime: player!.currentTime().seconds)
        startAndStopButton.setTitle(NSLocalizedString("Start", comment: "Start"), for: .normal)
        
        UDManager.setUDSHistory { [weak self] oldHistoryMG in
            guard let strongSelf = self else {
                return oldHistoryMG
            }
            oldHistoryMG.addHistory(date: Date(), exerciseName: strongSelf.exerciseStep.exerciseName, playTime: strongSelf.timerDisplay)
            return oldHistoryMG
        }
        
        historyVC.tableView.reloadData()
        
        UDManager.setUDSUser { [weak self] oldUser in
            guard let strongSelf = self else {
                return oldUser
            }
            oldUser.resetStateTime(step: strongSelf.exerciseStep.exerciseName)
            return oldUser
        }
        
        UDManager.setUDSExercise { [weak self] oldExercise in
            guard let strongSelf = self else {
                return oldExercise
            }
            oldExercise.exercise[strongSelf.exerciseVCIndex].videoCurrentTimer = strongSelf.player!.currentTime().seconds
            return oldExercise
        }
        
        //
        timerDisplay = 0
        
        
        if exerciseVCIndex == 5 {
            guard let unDoneIndexPage = UDManager.getUDSHistory().checkStepUnDone() else {
                alertAllStepDone()
                return
            }
            alertUnDoneStep(unDoneIndexPage: unDoneIndexPage)
            return
        }
        
        guard let unDonePageIndex = UDManager.getUDSHistory().checkStepUnDone() else {
            pageVC.goToNextPage(for: exerciseVCIndex)
            return
        }
        
        if unDonePageIndex < exerciseVCIndex {
            pageVC.goToUnDonePage(for: unDonePageIndex)
        }else {
            pageVC.goToNextPage(for: exerciseVCIndex)
        }
        
        
        
        
        //check if done all pages or undone some page
       
        
    }
    
    @objc private func countTimer(){
        timerDisplay += 1
        let abstime = abs(timerDisplay)
        if abstime >= 60 {
            let toTimeFormat = Date(timeIntervalSince1970: TimeInterval(abstime))
            timerLabel.text = "\(dateFormatter.string(from: toTimeFormat))"
        }else {
            timerLabel.text = "\(abstime)"
        }
    }
    
    @objc private func countDownFor3(){
        
        countDownTimer += 1
        let abstime = abs(countDownTimer)
        countDownTimerLabel.text = "\(abstime)"
        if abstime == 0{
            countDownTimerLabel.removeFromSuperview()
        }
        
    }
    
    private func alertAllStepDone(){
        let title = NSLocalizedString("High Five!!!", comment: "High Five!!!")
        let message = NSLocalizedString("""
                    Good job completing all six exercise!
                    Remember tomorrow's another day.
                    So eat well and get some rest.
                    """, comment: """
                    Good job completing all six exercise!
                    Remember tomorrow's another day.
                    So eat well and get some rest.
                    """)
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        //
        alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: "Dismiss"),
                                      style: .destructive,
                                      handler: { [weak self] _ in
                                        guard let strongSelf = self else {
                                            return
                                        }
                                        strongSelf.tabBarController?.selectedIndex = 0
                                        UDManager.setUDSUser { oldUser in
                                            oldUser.setCurrentPagingIndex(currentIndex: 0)
                                            return oldUser
                                        }
                                        let pageVC = strongSelf.parent as! ExercisePageViewController
                                        pageVC.goToNextPage(for: -1)
                                      }))

        present(alert, animated: true)
        
    }
    
    private func alertUnDoneStep(unDoneIndexPage:Int){
        let title = NSLocalizedString("You have skipped some step!!!", comment: "You have skipped some step!!!")
        let message = NSLocalizedString("Please go back and take these step", comment: "Please go back and take these step")
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Previous Step", comment: "Previous Step"),
                                      style: .default,
                                      handler: { [weak self] _ in
                                        guard let strongSelf = self else {
                                            return
                                        }
                                        let pageVC = strongSelf.parent as! ExercisePageViewController
                                        pageVC.goToUnDonePage(for: unDoneIndexPage)
                                      }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: "Dismiss"),
                                      style: .cancel))
        
        present(alert, animated: true)
        
    }
    
}

extension ExerciseViewController: Rate{
    
    func GetRate(rateIndex: Int) {
        UDManager.setUDSExercise { [weak self] oldExerciseMG in
            guard let strongSelf = self else {
                return oldExerciseMG
            }
            oldExerciseMG.exercise[strongSelf.exerciseVCIndex].rateIndex = rateIndex
            return oldExerciseMG
        }
    }
    
}






