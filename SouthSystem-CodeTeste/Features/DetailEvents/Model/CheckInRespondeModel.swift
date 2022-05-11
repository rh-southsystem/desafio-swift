//
//  CheckInRespondeModel.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 11/05/22.
//

import Foundation

struct CheckInRespondeModel: Decodable {
    enum Code: String, Decodable {
        case success = "200"
        case failure = "201"
        
        var response: String {
            switch self {
            case .success:
                return "Check-In realizado com sucesso"
            case .failure:
                return "Erro ao realizar Check-In"
            }
        }
    }
    
    var code: Code?
}
