//
//  ListEventsViewModel.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 09/05/22.
//

import Foundation

class ListEventsViewModel {
    
    let api = ListEventsAPI()
    var model: [ListEventsModel]?
    
    func loadData(_ completion: @escaping (String?) -> Void) {
        self.api.loadData { (model: [ListEventsModel]?, error) in
            self.model = model
            completion(error)
        }
    }
}
