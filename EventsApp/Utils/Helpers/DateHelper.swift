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
		var offset: Substring = ""
		
		if timeInterval.count > 3 {
			offset = timeInterval.dropLast(3)
			timeInterval.removeSubrange(timeInterval.index(timeInterval.endIndex, offsetBy: -3)..<timeInterval.endIndex)
		}
		
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE', 'MMMM d, yyyy 'AT' HH'h'MM 'min'"
		dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(offset) ?? 0)
		
		if let interval = Double(timeInterval) {
			if interval > 0 {
				return dateFormatter.string(from: Date(timeIntervalSince1970: interval))
			}
		}
		
		return EAStrings.unknownDate.rawValue
	}
}
