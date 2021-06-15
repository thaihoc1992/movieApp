//
//  Date.swift
//  MovieApp
//
//  Created by ADMIN on 6/5/21.
//

import Foundation
class Date {
    var numberDate: String
    var nameDate: String
    var isSelected: Bool
    
    init(numberDate: String, nameDate: String, isSelected: Bool = false) {
        self.numberDate = numberDate
        self.nameDate = nameDate
        self.isSelected = isSelected
    }
}

func bookingDates() -> [Date] {
    return [Date(numberDate: "1", nameDate: "Mon", isSelected: true),
            Date(numberDate: "2", nameDate: "Tue"),
            Date(numberDate: "3", nameDate: "Wed"),
            Date(numberDate: "4", nameDate: "Thu"),
            Date(numberDate: "5", nameDate: "Fri"),
            Date(numberDate: "6", nameDate: "Sat"),
            Date(numberDate: "7", nameDate: "Sun"),
            Date(numberDate: "8", nameDate: "Mon"),
            Date(numberDate: "9", nameDate: "Tue"),
            Date(numberDate: "10", nameDate: "Wed")
    ]
}
