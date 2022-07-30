//
//  LocationHelper.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import Foundation
import CoreLocation

class LocationHelper {
	static var shared = LocationHelper()
	
	func convertCoordinates(latitude: Double?, longitude: Double?) -> String {
		guard let latitude = latitude, let longitude = longitude else { return EAStrings.unknownLocal.rawValue}
		
		let geocoder = CLGeocoder()
		let coordinates = CLLocation(latitude: latitude, longitude: longitude)
		
		var address: String = ""
		
		geocoder.reverseGeocodeLocation(coordinates) { placeMark, error in
			if let place = placeMark?[0] {
				address = "\(place.name ?? "") - \(place.locality ?? "")-\(place.administrativeArea ?? "")"
			} else {
				address = EAStrings.unknownLocal.rawValue
			}
		}
		
		return address
	}
}
