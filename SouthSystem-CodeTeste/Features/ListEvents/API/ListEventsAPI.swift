//
//  ListEventsAPI.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 09/05/22.
//

import Foundation

class ListEventsAPI {
    struct Resources {
        static var baseUrl: String = "http://5f5a8f24d44d640016169133.mockapi.io/api"
        static var events: String = Resources.baseUrl + "/events"
    }
    
    func loadData(_ completion: @escaping ([ListEventsModel]?, String?) -> Void) {
        Services().request(Resources.events) { (list: [ListEventsModel]?, error) in
            completion(list, error)
        }
    }
}
