//
//  HomeCollectionViewCell.swift
//  MovieApp
//
//  Created by ADMIN on 6/1/21.
//

import UIKit
import Kingfisher
import Gemini

class HomeCollectionViewCell: GeminiCell {
        
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
        
    let filmImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 30
        image.backgroundColor = .clear
        image.clipsToBounds = true
        return image
    }()
    
    let voteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .orange
        label.textColor = .white
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
        var celldata : Movie? {
            didSet {
                if let celldata = celldata {
                    voteLabel.text = "★\(String(describing: celldata.voteAverage).suffix(4).prefix(3))"
                    filmImage.kf.setImage(with: URL(string: manageUrl.shared.photoBaseUrL + celldata.posterPath!))
                }
            }
        }

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
            containerView.addSubview(filmImage)
            containerView.addSubview(voteLabel)
            
            
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
            
            filmImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
            filmImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
            filmImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
            filmImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
            
            voteLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15).isActive = true
            voteLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true

        }

    }


