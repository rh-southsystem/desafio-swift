//
//  DetailEventViewModel.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 10/05/22.
//

import Foundation

class DetailEventViewModel {
    
    let api = DetailEventAPI()
    var model: EventsModel?
    var eventID: String
    
    init(eventID: String) {
        self.eventID = eventID
    }
    
    func loadData(_ completion: @escaping (String?) -> Void) {
        self.api.loadDetail(by: self.eventID) { model, error in
            self.model = model
            completion(error)
        }
    }
}
