//
//  FormView.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 31/07/22.
//

import UIKit

class FormView: UIView {

	// MARK: - Properties
	
	private var completion: ((String, String) -> Void)?
	private var showErrorNoInfo: (() -> Void)?

	private var stackView: UIStackView = {
		var view = UIStackView()
		
		view.axis = .vertical
		view.spacing = 15
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var titleLabel: UILabel = {
		var view = UILabel()
		
		view.text = EAStrings.formToConfirm.rawValue
		view.font = .systemFont(ofSize: 18, weight: .medium)
		view.textColor = .black
		view.textAlignment = .center
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var nameField: FormField = {
		var view = FormField(title: EAStrings.name.rawValue)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var emailField: FormField = {
		var view = FormField(title: EAStrings.email.rawValue)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var confirmButton: UIButton = {
		var view = UIButton(type: .roundedRect)
		
		view.setTitle(EAStrings.confirm.rawValue, for: .normal)
		view.tintColor = .white
		view.backgroundColor = .systemBlue
		view.layer.cornerRadius = 10
		view.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
		view.addTarget(self, action: #selector(didConfirm), for: .touchUpInside)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// MARK: - Init

	init(settings: [FormView.Settings]) {
		super.init(frame: .zero)
		
		setupView()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Settings
	
	enum Settings {
		case confirm((String, String) -> Void)
		case showErrorNoInfo(() -> Void)
	}
	
	func updateSettings(settings: [FormView.Settings]) {
		for setting in settings {
			switch setting {
			case .confirm(let completion):
				self.completion = completion
			case .showErrorNoInfo(let completion):
				self.showErrorNoInfo = completion
			}
		}
	}
	
	func clearFields() {
		nameField.textField.text = ""
		emailField.textField.text = ""
	}
}

extension FormView: ComponentCreation {
	func buildViewHierarchy() {
		self.addSubview(titleLabel)
		self.addSubview(stackView)
		stackView.addArrangedSubview(nameField)
		stackView.addArrangedSubview(emailField)
		stackView.addArrangedSubview(UIView())
		stackView.addArrangedSubview(confirmButton)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
			titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
			titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			
			stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
			stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
			stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25)
		])
	}
	
	func setupAdditionalConfiguration() {
		self.backgroundColor = .white
		self.layer.cornerRadius = 15
		
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowRadius = 15
		self.layer.shadowOpacity = 0.8
	}
}

private extension FormView {
	@objc func didConfirm() {
		if !(nameField.textField.text?.isEmpty ?? true) && !(emailField.textField.text?.isEmpty ?? true) {
			if let name = nameField.textField.text, let email = emailField.textField.text {
				completion?(name, email)
			}
		} else {
			showErrorNoInfo?()
		}
	}
}
