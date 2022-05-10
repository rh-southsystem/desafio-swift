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
}
