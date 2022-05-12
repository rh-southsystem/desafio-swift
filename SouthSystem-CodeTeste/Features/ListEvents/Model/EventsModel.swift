//
//  EventsModel.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 09/05/22.
//

import Foundation

struct EventsModel: Decodable {
    var title: String?
    var people: Array<String>?
    var date: Int?
    var description: String?
    var image: String?
    var longitude: Float?
    var latitude: Float?
    var price: Float?
    var id: String?
    
    var priceFormated: String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let value = formatter.string(from: (self.price ?? 0.0) as NSNumber) {
            return value
        }
        return nil
    }
    
    var dateFormated: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(self.date ?? 0))
        return dateFormatter.string(from: date)
    }
}
