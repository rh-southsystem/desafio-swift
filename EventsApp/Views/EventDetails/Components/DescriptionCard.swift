//
//  DescriptionCard.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import UIKit

class DescriptionCard: UIStackView {
	
	// MARK: - Properties
	
	private var descriptionTitleLabel: UILabel = {
		var view = UILabel()
		
		view.text = EAStrings.description.rawValue
		view.font = .systemFont(ofSize: 20, weight: .bold)
		view.textColor = .black
		view.numberOfLines = 0
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var descriptionLabel: UILabel = {
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

extension DescriptionCard: ComponentCreation {
	func buildViewHierarchy() {
		self.addArrangedSubview(descriptionTitleLabel)
		self.addArrangedSubview(descriptionLabel)
	}
	
	func setupConstraints() {
		
	}
	
	func setupAdditionalConfiguration() {
		self.axis = .vertical
		self.spacing = 5
	}
}
