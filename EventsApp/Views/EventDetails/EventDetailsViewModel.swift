//
//  EventDetailsViewModel.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class EventDetailsViewModel: EventDetailsViewModelProtocol {
	private(set) var event: BehaviorSubject<Event>?
	private let id: String
	
	init(id: String) {
		self.id = id
	}
	
	func fetchEvent(finish: @escaping (Error?) -> Void) {
		AF.request(Endpoints.eventsList.rawValue.appending(self.id)).response { [weak self] response in
			switch response.result {
			case .success(let data):
				do {
					guard let data = data else {
						finish(CustomError(errorDescription: EAStrings.noDataFound.rawValue))
						return
					}
					let newEvent = try JSONDecoder().decode(EventJSON.self, from: data)
					
					self?.event?.onNext(EventTransform(eventJSON: newEvent).entity)
				} catch {
					finish(error)
				}
				
			case .failure(let error):
				finish(error)
			}
		}
	}
}
