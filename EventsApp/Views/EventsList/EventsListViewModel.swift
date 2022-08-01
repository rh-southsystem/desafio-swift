//
//  EventsListViewModel.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift

final class EventsListViewModel: EventsListViewModelProtocol {
	var loading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
	
	var events = PublishSubject<[EventJSON]>()
	
	func fetchEventsList(finish: @escaping (Error?) -> Void) {
		
		loading.onNext(true)
		AF.request(Endpoints.eventsList.rawValue).response { [weak self] response in
			self?.loading.onNext(false)
			switch response.result {
			case .success(let data):
				do {
					guard let data = data else {
						finish(CustomError(errorDescription: EAStrings.noDataFound.rawValue))
						return
					}
					
					let newEventsArray = try JSONDecoder().decode([EventJSON].self, from: data)

					self?.events.onNext(newEventsArray)
					finish(nil)
				} catch {
					finish(error)
				}

			case .failure(let error):
				finish(error)
			}
		}
	}
}
