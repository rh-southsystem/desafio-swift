//
//  DetailsCard.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import UIKit

class DetailsCard: UIStackView {
	
	// MARK: - Properties
	
	var dateLabel: UILabel = {
		var view = UILabel()
		
		view.font = .systemFont(ofSize: 16, weight: .bold)
		view.textColor = .gray
		view.numberOfLines = 0
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var titleLabel: UILabel = {
		var view = UILabel()
		
		view.font = .systemFont(ofSize: 20, weight: .bold)
		view.textColor = .black
		view.numberOfLines = 0
		
		return view
	}()
	
	var localLabel: UILabel = {
		var view = UILabel()
		
		view.font = .systemFont(ofSize: 18)
		view.textColor = .gray
		view.numberOfLines = 0
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var priceLabel: UILabel = {
		var view = UILabel()
		
		view.font = .systemFont(ofSize: 18)
		view.textColor = .gray
		view.numberOfLines = 0
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// MARK: - Init

	init() {
		super.init(frame: .zero)
		
		setupView()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension DetailsCard: ComponentCreation {
	func buildViewHierarchy() {
		self.addArrangedSubview(dateLabel)
		self.addArrangedSubview(titleLabel)
		self.addArrangedSubview(localLabel)
		self.addArrangedSubview(priceLabel)
	}
	
	func setupConstraints() {
		
	}
	
	func setupAdditionalConfiguration() {
		self.axis = .vertical
	}
}
