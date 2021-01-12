//
//  Request.swift
//  eventos
//
//  Created by Enrique Dutra on 08/01/21.
//

import Foundation

class Request{
    
    let apiKey: String = "c5be45b322066cebf9d9b649b7640de9"
    let url: String = "https://api.themoviedb.org/3/movie/550?api_key="
    private let urlSession = URLSession.shared
    
    
    init(){
        
    }
    
    func getMovies(completionHandler: @escaping (_ response: MoviesResponse) -> Void){
        var fullURL = url + apiKey
        
//        print(fullURL)
        
        
        urlSession.dataTask(with: URL(string: fullURL)!) { (data, response, error) in
            
            
                if (error != nil){
                
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                
                return
            }
            guard let data = data else {
                            
                            return
            }
                        
            do {
                let jsonDecoder = JSONDecoder()
                let moviesResponse = try jsonDecoder.decode(MoviesResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(moviesResponse)
                }
//                            let moviesResponse = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
//                            DispatchQueue.main.async {
//                                successHandler(moviesResponse)
//                            }
           } catch {
//                            self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
           }
                        
            
            
            
            
        }.resume()
            
        
    }
}
