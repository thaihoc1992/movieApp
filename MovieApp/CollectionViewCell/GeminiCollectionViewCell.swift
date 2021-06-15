//
//  GeminiCollectionViewCell.swift
//  MovieApp
//
//  Created by ADMIN on 5/31/21.
//

import UIKit
import Kingfisher
class GeminiCollectionViewCell: UICollectionViewCell {
    let filmimage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var form: Movie? {
        didSet {
            if let form = form {
                filmimage.kf.setImage(with: URL(string: manageUrl.shared.photoBaseUrL + form.backdropPath!))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
    }
    func setupLayout() {
        self.addSubview(filmimage)
        
        filmimage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        filmimage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        filmimage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        filmimage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
    }
}
