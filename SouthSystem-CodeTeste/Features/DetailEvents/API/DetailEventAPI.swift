//
//  DetailEventAPI.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 10/05/22.
//

import Foundation

class DetailEventAPI {
    struct Resources {
        static var baseUrl: String = "http://5f5a8f24d44d640016169133.mockapi.io/api/"
        static var detail: String = Resources.baseUrl + "events"
    }
    
    func loadDetail(by id: String,_ completion: @escaping (EventsModel?, String?) -> Void) {
        let url = "\(Resources.detail)/\(id)"
        Services().request(url) { (model: EventsModel?, error) in
            completion(model, error)
        }
    }
}
