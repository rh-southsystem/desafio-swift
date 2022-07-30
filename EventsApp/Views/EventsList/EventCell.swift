//
//  EventCell.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit

class EventCell: UITableViewCell, ComponentCreation {
	static let identifier = "eventCell"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private let titleView: UILabel = {
		var view = UILabel()
		
		view.font = .systemFont(ofSize: 20)
		view.textAlignment = .left
		view.textColor = .black
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	func configCell(title: String) {
		titleView.text = title
	}
	
	func buildViewHierarchy() {
		self.contentView.addSubview(titleView)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
			titleView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
			titleView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
			titleView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15)
		])
	}
	
	func setupAdditionalConfiguration() {
		
	}
}
