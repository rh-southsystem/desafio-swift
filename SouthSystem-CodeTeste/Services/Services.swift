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
            urlComponente.queryItems = []
            for param in parameters {
                urlComponente.queryItems?.append(URLQueryItem(name: param.key, value: "\(param.value)"))
            }
        }

        guard let url = urlComponente.url else {
            completion(nil, "Sem url configurada")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        var headersDefault: [String: String] = [
            "Content-Type": "application/json"
        ]

        headers.forEach { key, value in
            headersDefault[key] = value
        }
        request.allHTTPHeaderFields = headersDefault

        if parameters.count > 0 && method == .post {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            debugPrint(url.absoluteString)
            if let headers = request.allHTTPHeaderFields {
                debugPrint("Headers: ", headers)
            }
            if let parametros = urlComponente.queryItems {
                debugPrint("Parametros: ", parametros)
            }

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
    
    func request<I: Decodable, T: Encodable>(_ urlstring: String, method: HTTPmethod = .get, encodable: T?, headers: [String:String] = [:], completion: @escaping (_ success: I?,_ error: String?) ->()) {
        DispatchQueue.main.async {
            guard let urlQuery = urlstring.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                var urlComponente = URLComponents(string: urlQuery) else {
                completion(nil, "Erro inesperado")
                return
            }

            if method == .get {
                if let encodableValues = encodable, let data = try? JSONEncoder().encode(encodableValues),
                   let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                    urlComponente.queryItems = []

                    for param in dictionary {
                        urlComponente.queryItems?.append(URLQueryItem(name: param.key, value: "\(param.value)"))
                    }
                }
            }

            guard let url = urlComponente.url else {
                completion(nil, "Sem url configurada")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue

            var headersDefault: [String: String] = [
                "Content-Type": "application/json"
            ]

            headers.forEach { key, value in
                headersDefault[key] = value
            }
            request.allHTTPHeaderFields = headersDefault

            if let encodable = encodable, method == .post {
                request.httpBody = try? JSONEncoder().encode(encodable)
            }

            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                debugPrint(url.absoluteString)
                if let headers = request.allHTTPHeaderFields {
                    debugPrint("Headers: ", headers)
                }
                if let parametros = urlComponente.queryItems {
                    debugPrint("Parametros: ", parametros)
                }

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
