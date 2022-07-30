//
//  File.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import Foundation

struct EventTransform {
	var entity: Event

	init(eventJSON: EventJSON) {
		let newDate = DateHelper.shared.dateConverter(value: eventJSON.date)
		let image = ImageHelper.shared.urlImageConverter(url: eventJSON.image)
		let local = LocationHelper.shared.convertCoordinates(latitude: eventJSON.latitude, longitude: eventJSON.longitude)
		
		entity = Event(id: eventJSON.id,
					   title: eventJSON.title,
//					   date: newDate,
					   description: eventJSON.description,
//					   image: image,
//					   local: local,
					   price: eventJSON.price)
	}
}
