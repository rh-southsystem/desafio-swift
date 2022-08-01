//
//  EventsListTests.swift
//  EventsAppTests
//
//  Created by Rodrigo Ryo Aoki on 31/07/22.
//

import XCTest
import RxCocoa
import RxSwift
@testable import EventsApp

class EventsListTests: XCTestCase {
	func testEventListViewModel() throws {
		let vm = EventsListViewModel()
		
		let bag = DisposeBag()
		
		let expec = expectation(description: "wait for API")
		
		vm.fetchEventsList { error in
			if let _ = error {
				XCTFail()
			}
			expec.fulfill()
		}
		
		vm.events.subscribe({ ev in
			if !(ev.element?.isEmpty ?? true) {
				XCTAssertEqual(ev.element?[0].title, "Feira de adoção de animais na Redenção")
				XCTAssertEqual(ev.element?[0].id, "1")
				XCTAssertEqual(ev.element?[1].title, "Doação de roupas")
				XCTAssertEqual(ev.element?[1].id, "2")
				XCTAssertEqual(ev.element?[2].title, "Feira de Troca de Livros")
				XCTAssertEqual(ev.element?[2].id, "3")
			}
		}).disposed(by: bag)
		
		waitForExpectations(timeout: 10)
	}
}
