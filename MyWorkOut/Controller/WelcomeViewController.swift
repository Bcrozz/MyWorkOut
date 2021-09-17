//
//  WelcomeViewController.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 9/9/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let profileImageView: UIImageView = {
        let profileImageView = UIImageView(image: UIImage(named: "Step-Up"))
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 64
        profileImageView.contentMode = .scaleToFill
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.systemPink.cgColor
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Get Fit", comment: "Get Fit")
        label.font = UIFont(name: "Rockwell Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let paragrLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("with high intensity interval traning", comment: "with high intensity interval traning")
        label.font = UIFont(name: "Rockwell", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Start", comment: "Start"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.clipsToBounds = true
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didTabStartButton), for: .touchUpInside)
        return button
    }()
    
    private let backgroundProfileImage: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Welcome", comment: "Welcome")
        setImageProfile()
        setHeaderLabelAndParagLabel()
        setStartButton()
    }

    private func setImageProfile(){
        view.addSubview(backgroundProfileImage)
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 128),
            profileImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 128),
            backgroundProfileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundProfileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundProfileImage.heightAnchor.constraint(equalToConstant: 40 + 64),
            backgroundProfileImage.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setHeaderLabelAndParagLabel() {
        view.addSubview(headerLabel)
        view.addSubview(paragrLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            paragrLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor,constant: 10),
            paragrLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
    }
    
    private func setStartButton() {
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: paragrLabel.layoutMarginsGuide.bottomAnchor,constant: 20),
            startButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTabStartButton(_ sender:UIButton){
        tabBarController?.selectedIndex = 1
    }

}
