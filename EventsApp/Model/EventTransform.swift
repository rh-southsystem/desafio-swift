//
//  File.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import Foundation
import UIKit

class EventTransform {
	static var shared = EventTransform()
	
	func transform(eventJSON: EventJSON, completion: @escaping (Event) -> Void) {
		let newDate = DateHelper.shared.dateConverter(value: eventJSON.date)
		
		ImageHelper.shared.urlImageConverter(url: eventJSON.image) { result in
			var imageData: Data?
			
			switch result {
			case .success(let data):
				imageData = data
				
			case .failure(_):
				imageData = nil
			}
			
			LocationHelper.shared.convertCoordinates(latitude: eventJSON.latitude, longitude: eventJSON.longitude) { local in
				
				completion(Event(id: eventJSON.id,
							   title: eventJSON.title ?? EAStrings.unknownName.rawValue,
							   date: newDate,
							   description: eventJSON.description ?? EAStrings.noDescriptionProvided.rawValue,
							   image: imageData,
							   local: local,
							   price: eventJSON.price ?? 0))
			}
		}
		
	}
}
