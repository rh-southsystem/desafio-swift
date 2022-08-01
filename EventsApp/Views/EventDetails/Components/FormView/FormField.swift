//
//  FormField.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 31/07/22.
//

import UIKit

class FormField: UIView {

	// MARK: - Properties
	
	private var titleLabel: UILabel = {
		var view = UILabel()
		
		view.font = .systemFont(ofSize: 16)
		view.textColor = .black
		view.textAlignment = .center
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var textField: UITextField = {
		var view = UITextField()
		
		view.backgroundColor = .systemGray4
		view.layer.cornerRadius = 5
		view.layer.borderColor = UIColor.systemGray.cgColor
		view.layer.borderWidth = 1
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// MARK: - Init

	init(title: String) {
		super.init(frame: .zero)
		
		titleLabel.text = title
		setupView()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension FormField: ComponentCreation {
	func buildViewHierarchy() {
		self.addSubview(titleLabel)
		self.addSubview(textField)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			titleLabel.widthAnchor.constraint(equalToConstant: 50),
			
			textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15),
			textField.topAnchor.constraint(equalTo: self.topAnchor),
			textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			textField.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
	}
	
	func setupAdditionalConfiguration() {

	}
}
