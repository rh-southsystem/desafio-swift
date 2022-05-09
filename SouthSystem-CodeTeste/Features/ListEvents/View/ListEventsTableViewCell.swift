//
//  ListEventsTableViewCell.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 09/05/22.
//

import Foundation
import UIKit

class ListEventsTableViewCell: UITableViewCell {
    
    private lazy var pictureImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.tintColor = .darkGray
        view.contentMode = .scaleAspectFill
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = " "
        view.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        view.textColor = .darkGray
        view.numberOfLines = 0
        
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = " "
        view.font = UIFont.systemFont(ofSize: 12, weight: .light)
        view.textColor = .gray
        view.numberOfLines = 5
        
        return view
    }()
    
    var title: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text  = newValue }
    }
    
    var desc: String? {
        get { return self.descriptionLabel.text }
        set { self.descriptionLabel.text  = newValue }
    }
    
    var image: String? {
        didSet {
            Services().carregarImage(self.image ?? "") { [weak self] image, _ in
                if let image = image {
                    self?.pictureImageView.image = image
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    func initialize() {
        self.configureViews()
    }
    
    private func configureViews() {
        self.accessoryType = .disclosureIndicator
        self.separatorInset = UIEdgeInsets(top: .zero, left: 81, bottom: .zero, right: .zero)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.pictureImageView)
        
        let padding: CGFloat = 15
        let imageSize: CGSize = CGSize(width: 60, height: 60)
        NSLayoutConstraint.activate([
            self.pictureImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding),
            self.pictureImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding),
            self.pictureImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            self.pictureImageView.heightAnchor.constraint(equalToConstant: imageSize.height)
        ])
        
        let imagePadding: CGFloat = 6
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: padding),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.pictureImageView.trailingAnchor, constant: imagePadding),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
        ])
        
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.pictureImageView.trailingAnchor, constant: imagePadding),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -padding),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
}
