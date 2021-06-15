//
//  CastCollectionViewCell.swift
//  MovieApp
//
//  Created by ADMIN on 6/3/21.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    
    var cellData: Cast? {
        didSet {
            if let cellData = cellData {
            castImage.kf.setImage(with: URL(string: manageUrl.shared.photoBaseUrL + (cellData.profilePath)!))
            castNameLabel.text = (cellData.name ?? "").uppercased()
            characterNameLabel.text = (cellData.character ?? "").uppercased()
            }
        }
    }
    
    let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let castImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    let castNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Chalkboard SE Bold", size: 10)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = "AAAA AAAA AAAA"
        return label
    }()
    
    let characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Chalkboard SE Bold", size: 9)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.alpha = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.text = "sdsdsdsds sdsdsdsds sdsdsdsds"
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
        containerView.addSubview(castImage)
        containerView.addSubview(castNameLabel)
        containerView.addSubview(characterNameLabel)
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        //
        castImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        castImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        castImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        castImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
        //
        castNameLabel.topAnchor.constraint(equalTo: castImage.bottomAnchor, constant: 5).isActive = true
        castNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
        castNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
        //
        characterNameLabel.topAnchor.constraint(equalTo: castNameLabel.bottomAnchor, constant: 5).isActive = true
        characterNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        characterNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
    }
}
