//
//  HelpersTests.swift
//  EventsAppTests
//
//  Created by Rodrigo Ryo Aoki on 28/07/22.
//

import XCTest
@testable import EventsApp

class HelpersTests: XCTestCase {
    func testLocationConvert() throws {
		let expec = expectation(description: "convertCoordinates")
		LocationHelper.shared.convertCoordinates(latitude: 37.33529212343718, longitude: -122.00901491570926) { local in
			print(local)
			
			XCTAssertEqual(local, "Apple Park - Cupertino-CA")
			expec.fulfill()
		}
		waitForExpectations(timeout: 5)
    }
	
	func testDateConvert() throws {
		let convert = DateHelper.shared.dateConverter(value: 1534784400000)
		let convert2 = DateHelper.shared.dateConverter(value: nil)
		
		XCTAssertEqual(convert, "Monday, August 20, 2018 AT 14h08 min")
		XCTAssertEqual(convert2, EAStrings.unknownDate.rawValue)
	}
	
	func testImageHelperConvert() throws {
		let expec = expectation(description: "convertCoordinates")
		ImageHelper.shared.urlImageConverter(url: "http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png") { result in
			
			switch result {
			case.success(let data):
				XCTAssertTrue(UIImage(data: data) != nil)
				expec.fulfill()
				
			case .failure(_):
				XCTFail()
				expec.fulfill()
			}
		}
		waitForExpectations(timeout: 5)
	}
	
	func testComponentCreation() throws {
		class Component: ComponentCreation {
			var buildViews = false
			var setupConst = false
			var additionalConfiguration = false
			
			init() {
				setupView()
			}
			
			func buildViewHierarchy() {
				buildViews = true
			}
			
			func setupConstraints() {
				setupConst = true
			}
			
			func setupAdditionalConfiguration() {
				additionalConfiguration = true
			}
		}
		
		let component = Component()
		
		XCTAssertTrue(component.buildViews)
		XCTAssertTrue(component.setupConst)
		XCTAssertTrue(component.additionalConfiguration)
	}
}
