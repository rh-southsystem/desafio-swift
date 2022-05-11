//
//  DetailEventViewModel.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 10/05/22.
//

import Foundation

class DetailEventViewModel {
    
    enum CheckInForm: String, CaseIterable {
        case email = "Email"
        case nome = "Nome"
    }
    
    private let api = DetailEventAPI()
    var model: EventsModel?
    private var eventID: String
    
    private lazy var form: [CheckInForm: String] = {
        var form: [CheckInForm: String] = [:]
        for field in CheckInForm.allCases {
            form[field] = ""
        }
        return form
    }()
    
    init(eventID: String) {
        self.eventID = eventID
    }
    
    func fill(field: String?, value: String?) {
        if let fieldString = field, let fieldEnum = CheckInForm(rawValue: fieldString) {
            self.form[fieldEnum] = value
        }
    }
    
    func validateFields() -> String? {
        var msgError: String = ""
        for field in CheckInForm.allCases {
            if let value = self.form[field], value.isEmpty {
                msgError += "\nO campo \(field.rawValue) é obrigatório"
            }
        }
        return msgError.isEmpty ? nil : msgError
    }
    
    func sendCheckIn(_ handler: @escaping (String?) -> Void) {
        let checkIn = CheckInModel(eventId: self.eventID,
                                   name: self.form[.nome],
                                   email: self.form[.email])
        self.api.send(checkIn: checkIn) { response in
            handler(response)
        }
    }
    
    func loadData(_ completion: @escaping (String?) -> Void) {
        self.api.loadDetail(by: self.eventID) { model, error in
            self.model = model
            completion(error)
        }
    }
}
