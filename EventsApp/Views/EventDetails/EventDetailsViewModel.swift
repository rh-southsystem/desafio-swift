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
	
	func fetchEvent(id: String, finish: @escaping (Error?) -> Void) {
		AF.request(Endpoints.eventsList.rawValue.appending(id)).response { [weak self] response in
			switch response.result {
			case .success(let data):
				do {
					guard let data = data else {
						finish(CustomError(errorDescription: EAStrings.noDataFound.rawValue))
						return
					}
					let newEvent = try JSONDecoder().decode(Event.self, from: data)
					
					self?.event?.onNext(newEvent)
				} catch {
					finish(error)
				}
				
			case .failure(let error):
				finish(error)
			}
		}
	}
}
