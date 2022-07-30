//
//  ComponentCreation.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import Foundation

protocol ComponentCreation {
	func buildViewHierarchy()
	func setupConstraints()
	func setupAdditionalConfiguration()
	func setupView()
}

extension ComponentCreation {
	func setupView(){
		buildViewHierarchy()
		setupConstraints()
		setupAdditionalConfiguration()
	}
}
