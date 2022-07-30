//
//  ViewModelProtocol.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import Foundation
import RxCocoa
import RxSwift

public protocol ViewModelProtocol {
	var loading: BehaviorSubject<Bool> { get }
}
