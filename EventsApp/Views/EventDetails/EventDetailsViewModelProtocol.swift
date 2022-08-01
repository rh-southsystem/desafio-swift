//
//  EventDetailsViewModelProtocol.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import Foundation
import RxSwift
import RxCocoa

public protocol EventDetailsViewModelProtocol: ViewModelProtocol {
	var event: BehaviorSubject<Event> { get }
	
	func fetchEvent(finish: @escaping (Error?) -> Void)
	func confirmPresence(name: String, email: String, completion: @escaping (Error?) -> Void)
}
