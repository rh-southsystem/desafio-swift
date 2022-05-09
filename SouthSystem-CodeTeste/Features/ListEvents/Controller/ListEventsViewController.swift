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
    
    var viewModel: ListEventsViewModel = ListEventsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.loadDataEvents()
    }
    
    @objc
    private func loadDataEvents() {
        self.tableView.refreshControl?.beginRefreshing()
        self.viewModel.loadData { [weak self] error in
            self?.tableView.refreshControl?.endRefreshing()
            if let msgError = error {
                let alertViewController = UIAlertController(title: "SouthSystem", message: msgError, preferredStyle: .alert)
                let actionOk = UIAlertAction(title: "OK", style: .default) { _ in
                    
                }
                alertViewController.addAction(actionOk)
                self?.present(alertViewController, animated: true, completion: nil)
                
                return
            }
            
            self?.tableView.reloadData()
        }
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
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.loadDataEvents), for: .valueChanged)
        for cell in Cells.allCases {
            self.tableView.register(cell.class, forCellReuseIdentifier: cell.rawValue)
        }
    }
}

extension ListEventsViewController: UITableViewDelegate {
    
}

extension ListEventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func dequeue<T: UITableViewCell>(_ tableView: UITableView, with identifier: String,_ indexPath: IndexPath) -> T {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
                return cell
            } else {
                return T(style: .default, reuseIdentifier: identifier)
            }
        }
        
        if let model = self.viewModel.model, indexPath.row < model.count {
            let event = model[indexPath.row]
            let cell: ListEventsTableViewCell = dequeue(tableView, with: Cells.event.rawValue, indexPath)
            
            return cell
        }
        
        return ListEventsTableViewCell()
    }
}
