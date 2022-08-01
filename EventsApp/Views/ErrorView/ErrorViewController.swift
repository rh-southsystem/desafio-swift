//
//  ErrorViewController.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import UIKit

class ErrorViewController: UIViewController {
	
	// MARK: - Properties
	
	private var outputHandler: ((ErrorViewController.Output) -> Void)?
	
	private var titleLabel: UILabel = {
		var view = UILabel()
		
		view.font = .systemFont(ofSize: 20)
		view.textColor = .gray
		view.numberOfLines = 0
		view.textAlignment = .center
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var okBtn: UIButton = {
		var view = UIButton(type: .roundedRect)
		
		view.setTitle(EAStrings.gotIt.rawValue, for: .normal)
		view.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var card: UIStackView = {
		var view = UIStackView()
		
		view.backgroundColor = .white
		view.axis = .vertical
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowRadius = 8
		view.layer.shadowOpacity = 0.3
		view.layer.cornerRadius = 15
		view.spacing = 15
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var background: UIView = {
		var view = UIView()
		
		view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// MARK: - Init
	
	required init(message: String, outputHandler: @escaping (ErrorViewController.Output) -> Void) {
		super.init(nibName: nil, bundle: nil)
		
		self.outputHandler = outputHandler
		
		titleLabel.text = message
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	enum Output {
		case close
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		self.view.backgroundColor = .clear
		setupView()
    }
}

extension ErrorViewController: ComponentCreation {
	func buildViewHierarchy() {
		self.view.addSubview(background)
		self.view.addSubview(card)
		self.card.addArrangedSubview(UIView())
		self.card.addArrangedSubview(titleLabel)
		self.card.addArrangedSubview(okBtn)
		self.card.addArrangedSubview(UIView())
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			background.topAnchor.constraint(equalTo: self.view.topAnchor),
			background.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			background.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			
			card.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
			card.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			card.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
			card.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
		])
	}
	
	func setupAdditionalConfiguration() {
		
	}
}

private extension ErrorViewController {
	@objc func tappedButton() {
		self.outputHandler?(.close)
	}
}
