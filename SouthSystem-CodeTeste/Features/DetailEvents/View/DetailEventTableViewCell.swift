//
//  DetailEventTableViewCell.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 10/05/22.
//

import Foundation
import UIKit

class DetailEventTableViewCell: ListEventsTableViewCell {
    
    override func initialize() {
        super.initialize()
        self.descriptionLabel.numberOfLines = 0
        self.accessoryType = .none
    }
}
