//
//  TimeCollectionViewCell.swift
//  MovieApp
//
//  Created by ADMIN on 6/6/21.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    var timeForm: Timeprice? {
        didSet {
            if let timeForm = timeForm {
                timeLabel.text = timeForm.time
                priceLabel.text = "$" + String(timeForm.price)
                if timeForm.isSelected == true {
                    containerView.backgroundColor = .red
                } else {
                    containerView.backgroundColor = .clear
                }
            }
        }
    }
    
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Chalkboard SE Bold", size: 15)
        label.textAlignment = .center
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Chalkboard SE Bold", size: 15)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
    
}

    required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupLayout()
    fatalError("init(coder:) has not been implemented")
}
    func setupLayout() {
        self.addSubview(containerView)
        containerView.addSubview(timeLabel)
        containerView.addSubview(priceLabel)
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        //
        timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -20).isActive = true
        //
        priceLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
     
    }
}


