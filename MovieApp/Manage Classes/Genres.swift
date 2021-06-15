//
//  Genres.swift
//  MovieApp
//
//  Created by ADMIN on 6/3/21.
//

import Foundation
class Genre {
    let id: Int
    let name: String
    
    init(id: Int, name: String ) {
        self.id = id
        self.name = name
    }
}
func totalGenres() -> [Genre] {
    return [Genre.init(id: 28, name: "Action"),
            Genre.init(id: 12, name: "Adventure"),
            Genre.init(id: 16, name: "Animation"),
            Genre.init(id: 35, name: "Comedy"),
            Genre.init(id: 80, name: "Crime"),
            Genre.init(id: 99, name: "Documentary"),
            Genre.init(id: 18, name: "Drama"),
            Genre.init(id: 10751, name: "Family"),
            Genre.init(id: 14, name: "Fantasy"),
            Genre.init(id: 36, name: "History"),
            Genre.init(id: 27, name: "Horror"),
            Genre.init(id: 10402, name: "Music"),
            Genre.init(id: 9648, name: "Mystery"),
            Genre.init(id: 10749, name: "Romance"),
            Genre.init(id: 878, name: "Science Fiction"),
            Genre.init(id: 10770, name: "TV Movie"),
            Genre.init(id: 53, name: "Thriller"),
            Genre.init(id: 10752, name: "War"),
            Genre.init(id: 37, name: "Western"),]
}
