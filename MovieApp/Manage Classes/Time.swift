//
//  Time.swift
//  MovieApp
//
//  Created by ADMIN on 6/6/21.
//

import Foundation
class Timeprice {
    var time: String
    var price: Double
    var isSelected: Bool
    
    init(time: String, price: Double, isSelected: Bool = false) {
        self.time = time
        self.price = price
        self.isSelected = isSelected
    }
    
}

func timepriceTag() -> [Timeprice] {
    return [Timeprice(time: "8:00 AM", price: 8.0, isSelected: true),
            Timeprice(time: "10:00 AM", price: 6.0),
            Timeprice(time: "12:00 AM", price: 6.0),
            Timeprice(time: "2:00 PM", price: 6.0),
            Timeprice(time: "4:00 PM", price: 8.0),
            Timeprice(time: "6:00 PM", price: 8.0),
            Timeprice(time: "8:00 PM", price: 8.0),
            Timeprice(time: "10:00 PM", price: 6.0),
            Timeprice(time: "00:00 AM", price: 6.0),
            Timeprice(time: "2:00 AM", price: 6.0)
    ]
}
