//
//  Event.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit

struct Event: Decodable {
	var id: String
	var date: Int?
	var description: String?
	var image: String?
	var latitude: Double?
	var longitude: Double?
	var price: Double?
	var title: String?
}
