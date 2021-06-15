//
//  DateCollectionViewCell.swift
//  MovieApp
//
//  Created by ADMIN on 6/5/21.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    var dateForm : Date? {
        didSet {
            if let dateForm = dateForm {
                numberDate.text = dateForm.numberDate
                nameDate.text = dateForm.nameDate
                if dateForm.isSelected == true {
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
    
    let numberDate : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Chalkboard SE Bold", size: 15)
        label.textAlignment = .center
        return label
    }()
    
    let nameDate : UILabel = {
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
        containerView.addSubview(numberDate)
        containerView.addSubview(nameDate)
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        //
        numberDate.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        numberDate.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20).isActive = true
        numberDate.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -20).isActive = true
        //
        nameDate.topAnchor.constraint(equalTo: numberDate.bottomAnchor, constant: 10).isActive = true
        nameDate.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        nameDate.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
     
    }
}
