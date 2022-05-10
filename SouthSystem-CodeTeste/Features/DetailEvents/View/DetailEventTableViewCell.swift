//
//  DetailEventTableViewCell.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 10/05/22.
//

import Foundation
import UIKit

class DetailEventTableViewCell: ListEventsTableViewCell {
    
    private lazy var localeLabel: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Localização", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return view
    }()
    
    override func initialize() {
        super.initialize()
        self.descriptionLabel.numberOfLines = 0
        self.accessoryType = .none
        
        self.contentView.addSubview(self.localeLabel)
        
        NSLayoutConstraint.activate([
            self.localeLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor),
            self.localeLabel.leadingAnchor.constraint(equalTo: self.pictureImageView.trailingAnchor, constant: 6),
            self.localeLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -6),
            self.localeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
