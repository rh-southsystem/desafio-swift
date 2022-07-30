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
	private(set) var event: BehaviorSubject<Event> = BehaviorSubject<Event>(value: Event(id: "", title: "", date: "", description: "", image: Data(), local: "", price: 0))
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
					
					EventTransform.shared.transform(eventJSON: newEvent) { [weak self] ev in
						self?.event.onNext(ev)
					}
				} catch {
					finish(error)
				}
				
			case .failure(let error):
				finish(error)
			}
		}
	}
	
	func fetchFoto(imgURL: String, result: @escaping (Result<Data, Error>) -> Void) {
		AF.request(imgURL).response {  response in
			switch response.result {
			case .success(let data):
				if let data = data {
					result(.success(data))
				} else {
					result(.failure(CustomError(errorDescription: EAStrings.noDataFound.rawValue)))
				}
				
			case .failure(let error):
				result(.failure(error))
			}
		}
	}
}
