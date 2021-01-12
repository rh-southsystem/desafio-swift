//
//  Request.swift
//  eventos
//
//  Created by Enrique Dutra on 08/01/21.
//

import Foundation

class Request{
    let session = URLSession.shared
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing/?api_key=c5be45b322066cebf9d9b649b7640de9")
    
    
    
    func nowPlayingMovieRequest (completion: @escaping ([Movie]) -> ()){
        if let url = self.url {
            let task = URLSession.shared.dataTask(with: url) {(nsData, urlResponse, error) in
                
                var movies:[Movie] = []
                
                if error == nil {
                    if let backData = nsData {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: backData, options: .allowFragments)
                            
                            if let dictionary = jsonResult as? [String : Any] {
                                
                                if let results = dictionary["results"] as? [[String : Any]]{
                                    for movie in results {
                                        if let movieObject = try? Movie(json: movie){
                                            movies.append(movieObject)
                                        }
                                    }
                                }
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                        completion(movies)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    
    
    func popularMoviesRequest(completion: @escaping ([Movie]) -> ()){
        
        if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=c5be45b322066cebf9d9b649b7640de9&language=en-US&page=1"){
            
            let task = URLSession.shared.dataTask(with: url) { (nsData,urlResponde,error) in
                
                var popularMovies: [Movie] = []
                
                if error == nil {
                    if let backData = nsData {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: backData, options: .allowFragments)
                            
                            if let popularMoviesObject = jsonResult as? [String : Any] {
                                
                                if let results = popularMoviesObject["results"] as? [[String : Any]] {
                                    
                                    for movie in results {
                                        if let movieObject = try? Movie(json: movie){
                                            
                                            popularMovies.append(movieObject)
                                        } else {
                                            print("nao rolou")
                                        }
                                    }
                                }
                            }
                            
                            
                        } catch {
                            
                            print(error.localizedDescription)
                        }
                        completion(popularMovies)
                    }
                } else {
                    print(error?.localizedDescription)
                }
                
                print("popular movies count: \(popularMovies.count)")
                
            }
            task.resume()
        }
    }
    
    
    
    //Mark: - request dos details de um filme pelo ID
    func movieDetailsRequest(id: Int, completion: @escaping (Movie) -> ()){
        if let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=c5be45b322066cebf9d9b649b7640de9") {
            let detailsTask = URLSession.shared.dataTask(with: url) {(nsData, urlResponse, error) in
                
                var movie: Movie
                
                if error == nil {
                    
                    if let backData = nsData {
                        do {
                            
                            let jsonResult = try JSONSerialization.jsonObject(with: backData, options: .allowFragments)
                            
                            if let movieObject = jsonResult as? [String : Any] {
                                
                            }
                            
                        }catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                } else {
                    print(error)
                }
            }
            detailsTask.resume()
        }
    }
    
    
    
    
    
    //MARK: - funcao para criar os objetos do tipo Movie
    func readJSONObject(object: [String : Any]) {
        var movies:[Movie] = []
        
        if let results = object["results"] as? [[String : Any]]{
            for movie in results {
                if let movieObject = try? Movie(json: movie){
                    movies.append(movieObject)
                }
            }
        }
        
        
        movies.forEach{
            print($0)
        }
    }
    
    
    
}

