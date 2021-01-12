//
//  Movies.swift
//  eventos
//
//  Created by Enrique Dutra on 08/01/21.
//

import Foundation

struct Movie : Decodable {
    
    let id : Int
    let original_title :String
    let genre_list : [String]
    let vote_average : Double
    let overview : String
    let photo : String
    

    
    init(json: [String : Any]) throws {
       
        
        self.id = json["id"] as? Int ?? 0
        self.original_title = json["original_title"] as? String ?? ""
        self.vote_average = json["vote_average"] as? Double ?? 0
        
        // fazer request do que ta faltando
        self.overview = json["overview"] as? String ?? ""
        let url = json["poster_path"]!
        self.photo = "https://image.tmdb.org/t/p/w200\(url)" as? String ?? ""
        
        self.genre_list = json["overview"] as? [String] ?? []
    }
    
}
