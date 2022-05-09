//
//  ListEventsViewController.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 09/05/22.
//

import Foundation
import UIKit

class ListEventsViewController : UIViewController {
    
    private enum Cells: String, CaseIterable {
        case event = "ListEventsTableViewCell"
        
        var `class`: AnyClass? {
            switch self {
            case .event:
                return ListEventsTableViewCell.self
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
    
    private func configureTableView() {
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        for cell in Cells.allCases {
            self.tableView.register(cell.class, forCellReuseIdentifier: cell.rawValue)
        }
    }
}

extension ListEventsViewController: UITableViewDelegate {
    
}

extension ListEventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func dequeue<T: UITableViewCell>(_ tableView: UITableView, with identifier: String,_ indexPath: IndexPath) -> T {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
                return cell
            } else {
                return T(style: .default, reuseIdentifier: identifier)
            }
        }
        
        let cell: ListEventsTableViewCell = dequeue(tableView, with: Cells.event.rawValue, indexPath)
        return cell
    }
}
