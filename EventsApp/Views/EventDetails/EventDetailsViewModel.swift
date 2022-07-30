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
	private(set) var loading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
	
	private(set) var event: BehaviorSubject<Event> = BehaviorSubject<Event>(value: Event(id: "", title: "", date: "", description: "", image: Data(), local: "", price: 0))
	private let id: String
	
	init(id: String) {
		self.id = id
	}
	
	func fetchEvent(finish: @escaping (Error?) -> Void) {
		loading.onNext(true)
		AF.request(Endpoints.eventsList.rawValue.appending(self.id)).response { [weak self] response in
			switch response.result {
			case .success(let data):
				do {
					guard let data = data else {
						finish(CustomError(errorDescription: EAStrings.noDataFound.rawValue))
						return
					}
					
					let newEvent = try JSONDecoder().decode(EventJSON.self, from: data)
					
					EventTransform.shared.transform(eventJSON: newEvent) { [weak self] ev in
						self?.loading.onNext(false)
						self?.event.onNext(ev)
					}
				} catch {
					finish(error)
					self?.loading.onNext(false)
				}
				
			case .failure(let error):
				finish(error)
				self?.loading.onNext(false)
			}
		}
	}
}
