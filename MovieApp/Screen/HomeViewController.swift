//
//  HomeViewController.swift
//  MovieApp
//
//  Created by ADMIN on 5/31/21.
//

import UIKit
import Gemini
import SwiftyJSON


class HomeViewController: UIViewController {
    var indexOfCellBeforeDragging = 0
    var data = [Movie]()
    var filterData = [Movie]()
    //
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello Học"
        label.textColor = .white
        label.font = UIFont(name: "Chalkboard SE Bold", size: 24)
        label.textAlignment = .center
        return label
    }()
    let subgreetingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Book your favorite movie"
        label.font = UIFont(name: "Chalkboard SE Bold", size: 15)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    let avaImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Huy")
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        return image
    }()
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = UIColor(red: 0.16, green: 0.17, blue: 0.22, alpha: 0.50)
        search.layer.cornerRadius = 14
        search.clipsToBounds = true
        search.placeholder = "Search movie"
        return search
    }()
    let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Chalkboard SE Bold", size: 25)
        return label
    }()
    var searching: Bool = false
    
    let cellWidth = (3 / 4) * UIScreen.main.bounds.width
    let cellHeight = (1 / 2) * UIScreen.main.bounds.height
    let sectionSpacing = (1 / 8) * UIScreen.main.bounds.width
    let cellSpacing = (1 / 16) * UIScreen.main.bounds.width
    
    lazy var collectionGemini : GeminiCollectionView = {
        let layout = PagingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = cellSpacing
        
        let collectionView = GeminiCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.06, green: 0.06, blue: 0.11, alpha: 1.00)
        collectionGemini.backgroundColor = .clear
        collectionGemini.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionGemini.contentInsetAdjustmentBehavior = .never
        collectionGemini.gemini.customAnimation()
            .translation(x:0,y: 50,z: 0)
            .rotationAngle(x:0,y: 13,z: 0)
            .ease(.easeOutExpo)
            .shadowEffect(.fadeIn)
            .maxShadowAlpha(0.3)
        collectionGemini.delegate = self
        collectionGemini.dataSource = self
        collectionGemini.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        getMovieApi { (movies) in
            guard let array = movies else {return}
            self.data = array
            self.collectionGemini.reloadData()
            let indexPath = NSIndexPath(row: 1, section: 0)
            self.collectionGemini.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
           
        } failure: { (error) in
            print(error)
        }
        searchBar.delegate = self
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(greetingLabel)
        view.addSubview(subgreetingLabel)
        view.addSubview(avaImage)
        view.addSubview(searchBar)
        view.addSubview(popularLabel)
        view.addSubview(collectionGemini)
        
        greetingLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30).isActive = true
        greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        //
        subgreetingLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10).isActive = true
        subgreetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        //
        avaImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30).isActive = true
        avaImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        avaImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avaImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        //
        searchBar.topAnchor.constraint(equalTo: subgreetingLabel.bottomAnchor, constant: 30).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //
        popularLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 50).isActive = true
        popularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        //
        collectionGemini.topAnchor.constraint(equalTo: popularLabel.topAnchor, constant: 20).isActive = true
        collectionGemini.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionGemini.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionGemini.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
}
    extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            collectionGemini.animateVisibleCells()
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if searching == true {
            return filterData.count
            } else {
                return data.count
            }
        }
        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if let cell = cell as? GeminiCell {
                        self.collectionGemini.animateCell(cell)
                    }
        }
        func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
            }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
            if searching == true {
            cell.celldata = filterData[indexPath.row]
                self.collectionGemini.animateCell(cell)
            } else {
                cell.celldata = data[indexPath.row]
                self.collectionGemini.animateCell(cell)
            }
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let detailVC = DetailViewController()
            if searching == true {
            detailVC.transit = filterData[indexPath.row]
            } else {
                detailVC.transit = data[indexPath.row]
            }
            let navigation = UINavigationController(rootViewController: detailVC)
            navigation.modalPresentationStyle = .fullScreen
            present(navigation, animated: true, completion: nil)
        }
    }


extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            searching = true
            filterData = data.filter({ $0.title!.contains(searchBar.text ?? "") })
            self.collectionGemini.reloadData()
        } else {
            searching = false
            self.collectionGemini.reloadData()
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searching = false
            searchBar.text = ""
            self.collectionGemini.reloadData()
        }
}
}
        
        


