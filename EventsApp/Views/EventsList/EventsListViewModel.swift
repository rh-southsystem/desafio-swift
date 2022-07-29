//
//  EventsListViewModel.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit
import Alamofire

final class EventsListViewModel: EventsListViewModelProtocol {
	private(set) var events: [Event]?
	
	func fetchEventsList(finish: @escaping (Error?) -> Void) {
		AF.request(Endpoints.eventsList.rawValue).response { [weak self] response in
			switch response.result {
			case .success(let data):
				do {
					guard let data = data else {
						finish(CustomError(errorDescription: EAStrings.noDataFound.rawValue))
						return
					}
					
					self?.events = try JSONDecoder().decode([Event].self, from: data)
				} catch {
					finish(error)
				}

			case .failure(let error):
				finish(error)
			}
		}
	}
}
