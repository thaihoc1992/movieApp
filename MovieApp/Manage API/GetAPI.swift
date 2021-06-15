//
//  GetAPI.swift
//  MovieApp
//
//  Created by ADMIN on 5/31/21.
//

import Foundation
import SwiftyJSON
import Alamofire


func getMovieApi(success: @escaping (([Movie]?) -> Void), failure: @escaping ((String) -> Void)) {
    let url = URL(string: manageUrl.shared.baseUrL + manageUrl.shared.moviesUrl)!
    AF.request(url , method: .get, encoding: URLEncoding.default).responseJSON {
        (response) in
        switch response.result {
        case .success(let value) :
            if let movieData = ResponseMovies(JSON(value)) {
                if movieData.results.count > 0 {
                    success(movieData.results)
                } else {
                    failure("Not found result")
                }
            }
        case.failure(let error):
            failure(error.localizedDescription)
            
        }
}
}

func getCastApi(_ idMovie: Int, success: @escaping (([Cast]?) -> Void), failure: @escaping ((String) -> Void)) {
    let url = URL(string: manageUrl.shared.baseUrL + "/movie/\(idMovie)/credits?api_key=9bb89316d8693b06d7a84980b29c011f&language=en-US")!
    AF.request(url , method: .get, encoding: URLEncoding.default).responseJSON { (response) in
        
        switch response.result {
        case .success(let value) :
        if let castData = ResponseCast(JSON(value)) {
            if castData.cast.count > 0 {
                success(castData.cast)
            }
        }
        case .failure(let error) :
            failure(error.localizedDescription)
        }
        
    }
}
