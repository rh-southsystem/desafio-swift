//
//  CheckInTest.swift
//  SouthSystem-CodeTesteTests
//
//  Created by Bruno Vieira on 11/05/22.
//

import XCTest
@testable import SouthSystem_CodeTeste

class CheckInTest: XCTestCase {
    
    var viewModel: DetailEventViewModel?

    override func setUpWithError() throws {
        self.viewModel = DetailEventViewModel(eventID: "1")
        self.viewModel?.fill(field: DetailEventViewModel.CheckInForm.email.rawValue, value: "bruno@email.com")
        self.viewModel?.fill(field: DetailEventViewModel.CheckInForm.nome.rawValue, value: "Bruno")
    }

    override func tearDownWithError() throws { }

    func testFieldsFilled() throws {
        XCTAssertEqual(self.viewModel?.validateFields(), nil)
    }
}
