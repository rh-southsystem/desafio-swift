//
//  DateHelper.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import Foundation

class DateHelper {
	static var shared = DateHelper()
	
	func dateConverter(value: Int?) -> String {
		var timeInterval = "\(value ?? 0)"
		let offset = timeInterval.dropLast(3)
		
		timeInterval.removeSubrange(timeInterval.index(timeInterval.endIndex, offsetBy: -3)..<timeInterval.endIndex)
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE', 'MMMM d, yyyy 'AT' HH'h'MM 'min'"
		dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(offset) ?? 0)
		
		if let interval = Double(timeInterval) {
			return dateFormatter.string(from: Date(timeIntervalSince1970: interval))
		}
		
		return EAStrings.unknownDate.rawValue
	}
}
