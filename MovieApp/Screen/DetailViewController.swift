//
//  DetailViewController.swift
//  MovieApp
//
//  Created by ADMIN on 6/3/21.
//

import UIKit
import Kingfisher
import SwiftyJSON

class DetailViewController: UIViewController {
    var castInfor = [Cast]()
    var genres = [Genre]()
    var transit : Movie? {
        didSet {
            if let transit = transit {
                getCastApi(transit.id ?? 0) { (cast) in
                    guard let array = cast else {return}
                    self.castInfor = array
                    self.castCollectionView.reloadData()
                } failure: { (error) in
                    print("\(error)")
                }
                //
                backgroundImage.kf.setImage(with: URL(string: manageUrl.shared.photoBaseUrlFullsize + (transit.backdropPath ?? "")))
                posterImage.kf.setImage(with: URL(string: manageUrl.shared.photoBaseUrL + (transit.posterPath ?? "")))
                nameLabel.text = transit.title
                voteLabel.text = "★\(String(describing: transit.voteAverage).suffix(4).prefix(3))/10"
                contentLabel.text = transit.overview
                if transit.genreIds.count >= 2 {
                    let g1 = totalGenres().first(where: {$0.id == transit.genreIds[0]})
                    let g2 = totalGenres().first(where: {$0.id == transit.genreIds[1]})
                    genreLabel.text = "\(transit.releaseDate ?? "") * \(g1?.name ?? "") & \(g2?.name ?? "")"
                } else if transit.genreIds.count == 1 {
                    let g1 = totalGenres().first(where: {$0.id == transit.genreIds[0]})
                    genreLabel.text = "\(transit.releaseDate ?? "") * \(g1?.name ?? "")"
                }
                  
                
            }
        }
    }
    

    let backgroundImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "avatar")
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        return image
    }()
    
    let coverView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let posterImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 24)
        label.textColor = .white
        return label
    }()
    
    let genreLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 15)
        label.textColor = .white
        return label
    }()
    
    let voteLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 15)
        label.tintColor = .white
        label.backgroundColor = .orange
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }()
    
    let castLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Chalkboard SE Bold", size: 24)
        label.text = "Cast"
        label.textColor = .white
        return label
    }()

    let castCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    let overviewLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        label.textColor = .white
        return label
    }()

    let contentLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Chalkboard SE Bold", size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.numberOfLines = 10
        return label
    }()
    
    let buyButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buy Ticket", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Chalkboard SE Bold", size: 15)
        button.backgroundColor = .red
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(gotoSeat), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.06, green: 0.06, blue: 0.11, alpha: 1.00)
        let leftbutton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(gobackHome))
        navigationItem.leftBarButtonItem = leftbutton
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        leftbutton.tintColor = .white
        //
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "CastCollectionViewCell")
        //
        genres = totalGenres()
        setupLayout()
    }
    @objc func gobackHome() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func gotoSeat() {
        let seatVC = SeatViewController()
        let navigation = UINavigationController(rootViewController: seatVC)
        seatVC.transitData = transit
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
    }
    
    func setupLayout() {
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(coverView)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(posterImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(genreLabel)
        containerView.addSubview(voteLabel)
        containerView.addSubview(castLabel)
        containerView.addSubview(castCollectionView)
        containerView.addSubview(overviewLabel)
        containerView.addSubview(contentLabel)
        view.addSubview(buyButton)
       
        
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        coverView.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 0).isActive = true
        coverView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 0).isActive = true
        coverView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: 0).isActive = true
        coverView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 0).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.2).isActive = true
        
        posterImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        posterImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        posterImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        posterImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1.2/3).isActive = true

        nameLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true

        genreLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true

        voteLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10).isActive = true
        voteLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 170).isActive = true
        voteLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -170).isActive = true


        castLabel.topAnchor.constraint(equalTo: voteLabel.bottomAnchor, constant: 5).isActive = true
        castLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        

        castCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 10).isActive = true
        castCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        castCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        castCollectionView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        overviewLabel.topAnchor.constraint(equalTo: castCollectionView.bottomAnchor, constant: 5).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        overviewLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        contentLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true

        buyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        buyButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
}
        
extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castInfor.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
        cell.cellData = castInfor[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 110, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}

