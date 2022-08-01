//
//  EventDetailsTests.swift
//  EventsAppTests
//
//  Created by Rodrigo Ryo Aoki on 31/07/22.
//

import XCTest
import RxSwift
import RxCocoa
@testable import EventsApp

class EventDetailsTests: XCTestCase {
    func testViewModel() throws {
		let vm = EventDetailsViewModel(id: "1")
		
		let bag = DisposeBag()
		
		let expec = expectation(description: "wait for API")
		
		vm.fetchEvent { error in
			if let _ = error {
				XCTFail()
			}
			expec.fulfill()
		}

		vm.event.subscribe({ ev in
			if ev.element?.title != ev.element?.date {
				XCTAssertEqual(ev.element?.title, "Feira de adoção de animais na Redenção")
				XCTAssertEqual(ev.element?.date, "Monday, August 20, 2018 AT 14h08 min")
				XCTAssertEqual(ev.element?.description, "O Patas Dadas estará na Redenção, nesse domingo, com cães para adoção e produtos à venda!\n\nNa ocasião, teremos bottons, bloquinhos e camisetas!\n\nTraga seu Pet, os amigos e o chima, e venha aproveitar esse dia de sol com a gente e com alguns de nossos peludinhos - que estarão prontinhos para ganhar o ♥ de um humano bem legal pra chamar de seu. \n\nAceitaremos todos os tipos de doação:\n- guias e coleiras em bom estado\n- ração (as que mais precisamos no momento são sênior e filhote)\n- roupinhas \n- cobertas \n- remédios dentro do prazo de validade")
				XCTAssertEqual(ev.element?.id, "1")
				XCTAssertEqual(ev.element?.local, "Rua Santana, 41 - Porto Alegre-RS")
				XCTAssertEqual(ev.element?.price, 29.99)
			}
		}).disposed(by: bag)
		
		waitForExpectations(timeout: 10)
    }
}
