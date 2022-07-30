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
	
	func convertCoordinates(latitude: Double?, longitude: Double?, completion: @escaping (String) -> Void) {
		guard let latitude = latitude, let longitude = longitude else { return }
		
		let geocoder = CLGeocoder()
		let coordinates = CLLocation(latitude: latitude, longitude: longitude)

		geocoder.reverseGeocodeLocation(coordinates) { placeMark, error in
			if let place = placeMark?[0] {
				completion("\(place.name ?? "") - \(place.locality ?? "")-\(place.administrativeArea ?? "")")
			} else {
				completion(EAStrings.unknownLocal.rawValue)
			}
		}
	}
}
