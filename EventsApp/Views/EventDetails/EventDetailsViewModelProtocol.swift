//
//  EventDetailsViewModelProtocol.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import Foundation
import RxSwift
import RxCocoa

public protocol EventDetailsViewModelProtocol {
	var event: BehaviorSubject<Event>? { get }
	
	func fetchEvent(id: String, finish: @escaping (Error?) -> Void)
}
