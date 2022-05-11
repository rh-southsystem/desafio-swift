//
//  DetailEventViewController.swift
//  SouthSystem-CodeTeste
//
//  Created by Bruno Vieira on 10/05/22.
//

import Foundation
import UIKit

class DetailEventViewController : UIViewController {
    
    private enum Cells: String, CaseIterable {
        case detail = "DetailEventTableViewCell"
        
        var `class`: AnyClass? {
            switch self {
            case .detail:
                return DetailEventTableViewCell.self
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var checkInButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Check-In", for: .normal)
        
        return view
    }()
    
    var viewModel: DetailEventViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureController()
        self.configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }
    
    private func configureController() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.checkInButton)
        self.checkInButton.addTarget(self, action: #selector(self.checkInAction(_:)), for: .touchUpInside)
    }
    
    @objc
    private func checkInAction(_ sender: UIButton) {
        let alertViewController = UIAlertController(title: "Check-In", message: "Informe usuário e senha para realizar check-in", preferredStyle: .alert)
        
        alertViewController.addTextField { textField in
            textField.placeholder = DetailEventViewModel.CheckInForm.email.rawValue
        }
        
        alertViewController.addTextField { textField in
            textField.placeholder = DetailEventViewModel.CheckInForm.nome.rawValue
        }
        
        let actionOk = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            let fields = alertViewController.textFields
            self?.viewModel?.fill(field: fields?[0].placeholder, value: fields?[0].text)
            self?.viewModel?.fill(field: fields?[1].placeholder, value: fields?[1].text)
            if let fieldError = self?.viewModel?.validateFields() {
                self?.show(message: fieldError)
            }
            self?.checkIn()
        }
        alertViewController.addAction(actionOk)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    private func checkIn() {
        self.tableView.refreshControl?.beginRefreshing()
        self.viewModel?.sendCheckIn({ [weak self] message in
            self?.tableView.refreshControl?.endRefreshing()
            if let response = message {
                self?.show(message: response)
            }
        })
    }
    
    private func loadData() {
        self.tableView.refreshControl?.beginRefreshing()
        self.viewModel?.loadData { [weak self] error in
            self?.tableView.refreshControl?.endRefreshing()
            if let msgError = error {
                self?.show(message: msgError)
                
                return
            }
            
            self?.tableView.reloadData()
        }
    }
    
    private func show(message error: String, with handler: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: "SouthSystem", message: error, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        alertViewController.addAction(actionOk)
        self.present(alertViewController, animated: true, completion: nil)
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
        self.tableView.allowsSelection = false
        for cell in Cells.allCases {
            self.tableView.register(cell.class, forCellReuseIdentifier: cell.rawValue)
        }
    }
}

extension DetailEventViewController: UITableViewDelegate {
    
}

extension DetailEventViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.model != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        func dequeue<T: UITableViewCell>(_ tableView: UITableView, with identifier: String,_ indexPath: IndexPath) -> T {
            if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
                return cell
            } else {
                return T(style: .default, reuseIdentifier: identifier)
            }
        }
        
        let cell: DetailEventTableViewCell = dequeue(tableView, with: Cells.detail.rawValue, indexPath)
        let model = self.viewModel?.model
        cell.title = model?.title
        cell.desc = model?.description
        cell.image = model?.image
        cell.date = model?.dateFormated
        cell.price = model?.priceFormated
        
        return cell
    }
}
