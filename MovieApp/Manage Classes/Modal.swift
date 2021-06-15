//
//  Modal.swift
//  MovieApp
//
//  Created by ADMIN on 5/31/21.
//

import Foundation
import SwiftyJSON

class ResponseMovies {
    var page: Int
    var results = [Movie]()
    var totalpages: Int
    var totalresults: Int
    
    required public init?(_ json: JSON) {
        page = json["page"].intValue
        results = json["results"].arrayValue.map { Movie($0)!}
        totalpages = json["total_pages"].intValue
        totalresults = json["total_results"].intValue
    }
}

class Movie {
    var adult: Bool?
    var backdropPath: String?
    var genreIds = [Int]()
    var id : Int?
    var originalLanguage: String?
    var originalTitle : String?
    var overview : String?
    var popularity : Double?
    var posterPath : String?
    var releaseDate : String?
    var title : String?
    var video : Bool?
    var voteAverage : Double?
    var voteCount : Int?
 
    required public init?(_ json: JSON) {
        adult = json["adult"].boolValue
        backdropPath = json["backdrop_path"].stringValue
        genreIds = json["genre_ids"].arrayValue.map{$0.intValue}
        id = json["id"].intValue
        originalLanguage = json["original_language"].stringValue
        originalTitle = json["original_title"].stringValue
        overview = json["overview"].stringValue
        popularity = json["popularity"].doubleValue
        posterPath = json["poster_path"].stringValue
        releaseDate = json["release_date"].stringValue
        title = json["title"].stringValue
        video = json["video"].boolValue
        voteAverage = json["vote_average"].doubleValue
        voteCount = json["vote_count"].intValue
    }
    
}

class ResponseCast {
    var id : Int?
    var cast = [Cast]()
    
    required public init?(_ json: JSON){
        id = json["id"].intValue
        cast = json["cast"].arrayValue.map{Cast($0)!}
    }
}

class Cast {
    var adult : Bool?
    var gender : Int?
    var id : Int?
    var knownForDepartment : String?
    var name : String?
    var originalName : String?
    var popularity : Double?
    var profilePath : String?
    var castId : Int?
    var character : String?
    var creditId : String?
    var order : Int?

    required public init?(_ json: JSON){
        adult = json["adult"].boolValue
        gender = json["gender"].intValue
        id = json["id"].intValue
        knownForDepartment = json["known_for_department"].stringValue
        name = json["name"].stringValue
        originalName = json["original_name"].stringValue
        popularity = json["popularity"].doubleValue
        profilePath = json["profile_path"].stringValue
        castId = json["cast_id"].intValue
        character = json["character"].stringValue
        creditId = json["credit_id"].stringValue
        order = json["order"].intValue
    }
}
