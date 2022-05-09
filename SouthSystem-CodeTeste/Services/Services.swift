//
//  Service.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 09/05/22.
//

import Foundation

import Foundation
import UIKit

class Services {
    
    enum HTTPmethod: String {
        case post
        case get
    }
    
    func request<I: Decodable>(_ urlstring: String, method: HTTPmethod = .get, parameters: [String:Any] = [:], headers: [String:String] = [:], completion: @escaping (_ success: I?,_ error: String?) ->()) {
        
        guard let urlQuery = urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            var urlComponente = URLComponents(string: urlQuery) else {
            completion(nil, "Erro inesperado")
            return
        }
        
        if method == .get {
            for param in parameters {
                urlComponente.queryItems = []
                urlComponente.queryItems?.append(URLQueryItem(name: param.key, value: "\(param.value)"))
            }
        }
        
        guard let url = urlComponente.url else { return }
        debugPrint(url.absoluteString)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if headers.count > 0 {
            request.allHTTPHeaderFields = headers
            debugPrint("Headers: ",headers)
            
        }
        
        if parameters.count > 0 && method != .get {
            let jsonSerialization = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonSerialization
            
            debugPrint("Parametros: ",parameters)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let msgError = error {
                DispatchQueue.main.async {
                    completion(nil, msgError.localizedDescription)
                }
                return
            }
            
            if let response = data {
                let debugJson = try? JSONSerialization.jsonObject(with: response, options: JSONSerialization.ReadingOptions.allowFragments)
                debugPrint(debugJson ?? "")
                
                if let object = try? JSONDecoder().decode(I.self, from: response) {
                    DispatchQueue.main.async {
                        completion(object, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, "Erro servidor")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, "Erro inesperado")
                }
            }
        }

        task.resume()
    }
    
    func carregarImage(_ urlstring: String, completion: @escaping (_ success: UIImage?,_ error: String?) ->()) {
        
        guard let _ = urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlstring) else {
            completion(nil, "Erro inesperado")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPmethod.get.rawValue
        request.cachePolicy = .useProtocolCachePolicy
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let msgError = error {
                DispatchQueue.main.async {
                    completion(nil, msgError.localizedDescription)
                }
                return
            }
            
            if let response = data {
                let image = UIImage.init(data: response)
                DispatchQueue.main.async {
                    completion(image, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, "Erro inesperado")
                }
            }
        }

        task.resume()
    }    
}
