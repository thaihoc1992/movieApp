//
//  SeatViewController.swift
//  MovieApp
//
//  Created by ADMIN on 6/5/21.
//

import UIKit
import Kingfisher

class SeatViewController: UIViewController {
    var transitTime: String = "8:00 AM"
    var transitDate: String = "1-Jun Mon"
    var bookseat = [String]()
    var price: Double = 8
    var amountSeats: Double = 0
    var dateIndex = 0
    var dateData: [Date] = bookingDates()
    var timeData: [Timeprice] = timepriceTag()
    var transitData : Movie? {
        didSet {
            guard let transitData = transitData else {return}
            nameLabel.text = transitData.title?.uppercased()
            backgroundImage.kf.setImage(with: URL(string: manageUrl.shared.photoBaseUrlFullsize + transitData.backdropPath!))
        }
    }
    let backgroundImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let coverView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "King Kong"
        label.font = UIFont(name: "Chalkboard SE Bold", size: 25)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let dateCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
        
    }()
    
    let timeCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
        
    }()
    
    let screenTV : ScreenTVView = {
        let screen = ScreenTVView()
        screen.translatesAutoresizingMaskIntoConstraints = false
        screen.backgroundColor = .clear
        return screen
    }()
    
    let screenLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SCREEN"
        label.font = UIFont(name: "Chalkboard SE Bold", size: 25)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let seatStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    let availableSeat : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.00)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let availableLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Available"
        label.font = UIFont(name: "Chalkboard SE Bold", size: 11)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let occupiedSeat : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let occupiedLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Occupied"
        label.font = UIFont(name: "Chalkboard SE Bold", size: 11)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()


    let selectedSeat : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let selectedLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Selected"
        label.font = UIFont(name: "Chalkboard SE Bold", size: 11)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let feeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Total: $0"
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 25)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }()
    
    let bookButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Book Now", for: .normal)
        button.titleLabel?.font = UIFont(name: "Chalkboard SE Bold", size: 15)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(bookTicket), for: .touchUpInside)
        return button
    }()
    
    let alert = UIAlertController(title: "Alert", message: "You need select seats", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBar = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.left"), style: .done, target: self, action: #selector(gobackDetail))
        navigationItem.leftBarButtonItem = leftBar
        leftBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        setupLayout()
        dateCollection.delegate = self
        dateCollection.dataSource = self
        dateCollection.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: "DateCollectionViewCell")
        timeCollection.delegate = self
        timeCollection.dataSource = self
        timeCollection.register(TimeCollectionViewCell.self, forCellWithReuseIdentifier: "TimeCollectionViewCell")
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        // Do any additional setup after loading the view.
        for i in Position.shared.rows {
            let miniStack : UIStackView = {
                let stack = UIStackView()
                stack.translatesAutoresizingMaskIntoConstraints = false
                stack.axis = .horizontal
                stack.distribution = .fillEqually
                stack.spacing = 8
                return stack
            }()
            seatStack.addArrangedSubview(miniStack)
            for j in Position.shared.columns {
                var isSelected: Bool = true
                var cG : UIColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.00)
                if (i=="B" && j=="5") || (i=="B" && j=="6") {
                    isSelected = false
                    cG = .yellow
                } else {
                    isSelected = true
                    cG = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.00)
                }
                let seat : buttonSeat = {
                    let button = buttonSeat()
                    button.select = false
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.backgroundColor = cG
                    button.layer.cornerRadius = 10
                    button.clipsToBounds = true
                    button.addTarget(self, action: #selector(onbuttonSeat), for: .touchUpInside)
                    button.isEnabled = isSelected
                    button.setTitle("\(i)\(j)", for: .normal)
                    button.appendSeat = "\(i)\(j)"
                    return button
                }()
                miniStack.addArrangedSubview(seat)
            }
        }
    }
    @objc func bookTicket() {
        if amountSeats > 0 {
            let TKVC = TicketViewController()
            let navigation = UINavigationController(rootViewController: TKVC)
            navigation.modalPresentationStyle = .fullScreen
            present(navigation, animated: true, completion: nil)
            TKVC.nameLabel.text = nameLabel.text
            TKVC.positionLabel.text = bookseat.joined(separator: ",")
            TKVC.dateLabel.text = transitDate
            TKVC.timeLabel.text = transitTime
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func gobackDetail() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onbuttonSeat(_ sender : buttonSeat){
        if sender.select == false {
            bookseat.append(sender.appendSeat ?? "")
            sender.select = true
            sender.backgroundColor = .red
            amountSeats += 1
            feeLabel.text = "Total: $\(amountSeats*price)"
        } else {
            sender.select = false
            sender.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.00)
            amountSeats -= 1
            feeLabel.text = "Total: $\(amountSeats*price)"
            var j = -1
            for item in bookseat {
                j += 1
                if item == sender.appendSeat! {
                    bookseat.remove(at: j)
                    j -= 1
                }
            }
        }
    }
    
    
    func setupLayout() {
        view.addSubview(backgroundImage)
        view.addSubview(coverView)
        view.addSubview(nameLabel)
        view.addSubview(dateCollection)
        view.addSubview(timeCollection)
        view.addSubview(screenTV)
        view.addSubview(screenLabel)
        view.addSubview(seatStack)
        view.addSubview(availableSeat)
        view.addSubview(availableLabel)
        view.addSubview(occupiedSeat)
        view.addSubview(occupiedLabel)
        view.addSubview(selectedSeat)
        view.addSubview(selectedLabel)
        view.addSubview(feeLabel)
        view.addSubview(bookButton)
        
        
    
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        coverView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        coverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        coverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        coverView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        nameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        dateCollection.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        dateCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        dateCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        dateCollection.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        timeCollection.topAnchor.constraint(equalTo: dateCollection.bottomAnchor, constant: 10).isActive = true
        timeCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        timeCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        timeCollection.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        screenTV.topAnchor.constraint(equalTo: timeCollection.bottomAnchor, constant: 8).isActive = true
        screenTV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        screenTV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        screenTV.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        screenLabel.topAnchor.constraint(equalTo: screenTV.bottomAnchor, constant: 5).isActive = true
        screenLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        screenLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        seatStack.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: 20).isActive = true
        seatStack.leadingAnchor.constraint(equalTo: screenLabel.leadingAnchor, constant: 0).isActive = true
        seatStack.trailingAnchor.constraint(equalTo: screenLabel.trailingAnchor, constant: 0).isActive = true
      
        
        availableSeat.topAnchor.constraint(equalTo: seatStack.bottomAnchor, constant: 20).isActive = true
        availableSeat.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        availableSeat.widthAnchor.constraint(equalToConstant: 30).isActive = true
        availableSeat.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        availableLabel.topAnchor.constraint(equalTo: availableSeat.bottomAnchor, constant: 5).isActive = true
        availableLabel.centerXAnchor.constraint(equalTo: availableSeat.centerXAnchor, constant: 0).isActive = true
        
        occupiedSeat.topAnchor.constraint(equalTo: seatStack.bottomAnchor, constant: 20).isActive = true
        occupiedSeat.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        occupiedSeat.widthAnchor.constraint(equalToConstant: 30).isActive = true
        occupiedSeat.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        occupiedLabel.topAnchor.constraint(equalTo: occupiedSeat.bottomAnchor, constant: 5).isActive = true
        occupiedLabel.centerXAnchor.constraint(equalTo: occupiedSeat.centerXAnchor, constant: 0).isActive = true
        
        selectedSeat.topAnchor.constraint(equalTo: seatStack.bottomAnchor, constant: 20).isActive = true
        selectedSeat.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80).isActive = true
        selectedSeat.widthAnchor.constraint(equalToConstant: 30).isActive = true
        selectedSeat.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        selectedLabel.topAnchor.constraint(equalTo: selectedSeat.bottomAnchor, constant: 5).isActive = true
        selectedLabel.centerXAnchor.constraint(equalTo: selectedSeat.centerXAnchor, constant: 0).isActive = true
        
        feeLabel.topAnchor.constraint(equalTo: availableSeat.bottomAnchor, constant: 40).isActive = true
        feeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        bookButton.topAnchor.constraint(equalTo: availableSeat.bottomAnchor, constant: 40).isActive = true
        bookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45).isActive = true
        bookButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        bookButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}
extension SeatViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dateCollection {
        return dateData.count
        } else {
            return timeData.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dateCollection {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCollectionViewCell", for: indexPath) as! DateCollectionViewCell
        cell.dateForm = dateData[indexPath.row]
        return cell
            } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCollectionViewCell", for: indexPath) as! TimeCollectionViewCell
            cell.timeForm = timeData[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dateCollection {
        return CGSize(width: 50, height: 80)
            } else {
         return CGSize(width: 90, height: 70)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == dateCollection {
                transitDate = dateData[indexPath.row].numberDate + "-Jun " + dateData[indexPath.row].nameDate
        for i in 0..<dateData.count {
            if i == indexPath.row {
                if dateData[i].isSelected == false {
                    dateData[i].isSelected = true
                    collectionView.reloadData()
                }
            } else {
                dateData[i].isSelected = false
                collectionView.reloadData()
                }
            }

        } else {
                transitTime = timeData[indexPath.row].time
            if timeData[indexPath.row].isSelected == false {
                price = timeData[indexPath.row].price
                feeLabel.text = "Total: $\(amountSeats*price)"
                collectionView.reloadData()
            } else {
                feeLabel.text = "Total: $\(amountSeats*price)"
                collectionView.reloadData()
            }
            
            for i in 0..<timeData.count {
                if i == indexPath.row {
                    if timeData[i].isSelected == false {
                    timeData[i].isSelected = true
                    collectionView.reloadData()
                    }
                } else {
                    timeData[i].isSelected = false
                    collectionView.reloadData()
                }
            }
        }
    }
}


