//
//  EventJSON.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit

public struct EventJSON: Decodable {
	var id: String
	var date: Int?
	var description: String?
	var image: String?
	var latitude: Double?
	var longitude: Double?
	var price: Double?
	var title: String?
}
