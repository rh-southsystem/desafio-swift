//
//  DetailEventTableViewCell.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 10/05/22.
//

import Foundation
import UIKit

class DetailEventTableViewCell: ListEventsTableViewCell {
    
    private lazy var localeButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Localização", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return view
    }()
    
    var locationHandler: (() -> Void)?
    
    override func initialize() {
        super.initialize()
        self.descriptionLabel.numberOfLines = 0
        self.accessoryType = .none
        
        self.contentView.addSubview(self.localeButton)
        
        NSLayoutConstraint.activate([
            self.localeButton.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor),
            self.localeButton.leadingAnchor.constraint(equalTo: self.pictureImageView.trailingAnchor, constant: 6),
            self.localeButton.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -6),
            self.localeButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        self.localeButton.addTarget(self, action: #selector(self.locationAction(_:)), for: .touchUpInside)
    }
    
    @objc
    private func locationAction(_ sender: UIButton) {
        self.locationHandler?()
    }
}
