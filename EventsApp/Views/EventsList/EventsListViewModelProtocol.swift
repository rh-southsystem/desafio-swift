//
//  EventsListViewModelProtocol.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import Foundation
import RxCocoa
import RxSwift

public protocol EventsListViewModelProtocol: ViewModelProtocol {
	var events: PublishSubject<[EventJSON]> { get }
	
	func fetchEventsList(finish: @escaping (Error?) -> Void)
}
