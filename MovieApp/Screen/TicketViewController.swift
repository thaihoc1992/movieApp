//
//  TicketViewController.swift
//  MovieApp
//
//  Created by ADMIN on 6/8/21.
//

import UIKit

class TicketViewController: UIViewController {
 
    let backgroundView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "King Kong"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 30)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let activeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Active"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        return label
    }()
    
    let minLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "90 Min"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        return label
    }()
    
    let qrcodeImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "QRCode")
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        return image
    }()
    let seatLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Seats"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        return label
    }()
    
    let positionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A1,A2"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        return label
    }()

    let datetimeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Time"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        return label
    }()
    
    let orderLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Order Number"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        return label
    }()
    
    let orderNumberLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = UUID().uuidString
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkboard SE Bold", size: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
       
        let leftbutton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.left.square"), style: .done, target: self, action: #selector(backtoSeat))
        navigationItem.leftBarButtonItem = leftbutton
        leftbutton.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        setupLayout()
   
    }
    
    @objc func backtoSeat() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupLayout(){
        view.addSubview(backgroundView)
        view.addSubview(nameLabel)
        view.addSubview(qrcodeImage)
        qrcodeImage.addSubview(activeLabel)
        qrcodeImage.addSubview(minLabel)
        view.addSubview(seatLabel)
        view.addSubview(positionLabel)
        view.addSubview(datetimeLabel)
        view.addSubview(timeLabel)
        view.addSubview(dateLabel)
        view.addSubview(orderLabel)
        view.addSubview(orderNumberLabel)
        
        
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        //
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //
        
        qrcodeImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40).isActive = true
        qrcodeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        qrcodeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        qrcodeImage.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        //
        
        activeLabel.topAnchor.constraint(equalTo: qrcodeImage.topAnchor, constant: 25).isActive = true
        activeLabel.leadingAnchor.constraint(equalTo: qrcodeImage.leadingAnchor, constant: 85).isActive = true
        
        //
        
        minLabel.topAnchor.constraint(equalTo: qrcodeImage.topAnchor, constant: 25).isActive = true
        minLabel.trailingAnchor.constraint(equalTo: qrcodeImage.trailingAnchor, constant: -85).isActive = true
        
        //
        
        seatLabel.topAnchor.constraint(equalTo: qrcodeImage.bottomAnchor, constant: 20).isActive = true
        seatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        seatLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        seatLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //
        
        positionLabel.topAnchor.constraint(equalTo: seatLabel.bottomAnchor, constant: 10).isActive = true
        positionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        positionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        positionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    
        //
        
        datetimeLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 20).isActive = true
        datetimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        datetimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        datetimeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //
        
        timeLabel.topAnchor.constraint(equalTo: datetimeLabel.bottomAnchor, constant: 10).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //
        
        dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //
        
        orderLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        orderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        orderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        orderLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //
        
        orderNumberLabel.topAnchor.constraint(equalTo: orderLabel.bottomAnchor, constant: 10).isActive = true
        orderNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        orderNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        orderNumberLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
