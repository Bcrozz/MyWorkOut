//
//  RateView.swift
//  MyWorkOut
//
//  Created by Kittisak Boonchalee on 14/9/21.
//

import UIKit

class RateView: UIView {
    
    weak var delegate: Rate?
    var rateIndex:Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpRateImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setUpRateImage(){

        let rateImageView0 = ceateRateImageView(indexTag: 1)
        let rateImageView1 = ceateRateImageView(indexTag: 2)
        let rateImageView2 = ceateRateImageView(indexTag: 3)
        let rateImageView3 = ceateRateImageView(indexTag: 4)
        let rateImageView4 = ceateRateImageView(indexTag: 5)
        
        addSubview(rateImageView0)
        addSubview(rateImageView1)
        addSubview(rateImageView2)
        addSubview(rateImageView3)
        addSubview(rateImageView4)
        
        
        NSLayoutConstraint.activate([
            rateImageView0.topAnchor.constraint(equalTo: topAnchor),
            rateImageView0.bottomAnchor.constraint(equalTo: bottomAnchor),
            rateImageView0.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.20),
            rateImageView0.leadingAnchor.constraint(equalTo: leadingAnchor),
            rateImageView1.topAnchor.constraint(equalTo: topAnchor),
            rateImageView1.bottomAnchor.constraint(equalTo: bottomAnchor),
            rateImageView1.leadingAnchor.constraint(equalTo: rateImageView0.trailingAnchor),
            rateImageView1.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.20),
            rateImageView2.topAnchor.constraint(equalTo: topAnchor),
            rateImageView2.bottomAnchor.constraint(equalTo: bottomAnchor),
            rateImageView2.leadingAnchor.constraint(equalTo: rateImageView1.trailingAnchor),
            rateImageView2.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.20),
            rateImageView3.topAnchor.constraint(equalTo: topAnchor),
            rateImageView3.bottomAnchor.constraint(equalTo: bottomAnchor),
            rateImageView3.leadingAnchor.constraint(equalTo: rateImageView2.trailingAnchor),
            rateImageView3.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.20),
            rateImageView4.topAnchor.constraint(equalTo: topAnchor),
            rateImageView4.bottomAnchor.constraint(equalTo: bottomAnchor),
            rateImageView4.leadingAnchor.constraint(equalTo: rateImageView3.trailingAnchor),
            rateImageView4.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.20)
        ])
    }
    
    @objc func colorRate(_ sender: UITapGestureRecognizer){
        if rateIndex == sender.view!.tag{
            for rateView in subviews{
                rateView.tintColor = .lightGray
            }
            rateIndex = 0
        }
        else {
            for rateView in subviews{
                if rateView.tag <= sender.view!.tag{
                    rateView.tintColor = .systemRed
                }else {
                    rateView.tintColor = .lightGray
                }
            }
            rateIndex = sender.view!.tag
        }
        delegate?.GetRate(rateIndex: rateIndex)
    }
    
    func ceateRateImageView(indexTag:Int) -> UIImageView{
        let rateImage = UIImage(systemName: "waveform.path.ecg")
        let rateImageView = UIImageView(image: rateImage)
        rateImageView.translatesAutoresizingMaskIntoConstraints = false
        rateImageView.isUserInteractionEnabled = true
        rateImageView.tag = indexTag
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(colorRate))
        rateImageView.addGestureRecognizer(gesture)
        
        return rateImageView
    }
    
    func setRate(rate:Int){
        for rateView in subviews{
            if rateView.tag <= rate{
                rateView.tintColor = .systemRed
            }else {
                rateView.tintColor = .lightGray
            }
        }
    }
    
}

protocol Rate: AnyObject {
    func GetRate(rateIndex:Int)
}
