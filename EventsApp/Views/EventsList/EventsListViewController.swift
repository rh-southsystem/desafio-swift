//
//  EventsListViewController.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 28/07/22.
//

import UIKit
import RxSwift
import RxCocoa

class EventsListViewController: UIViewController {
	
	// MARK: - Properties
	
	private var viewModel: EventsListViewModelProtocol?
	private var outputHandler: ((EventsListViewController.Output) -> Void)?
	private let bag = DisposeBag()
	
	private var tableView: UITableView = {
		let view = UITableView()
		view.separatorStyle = .singleLine
		view.separatorColor = .black
		view.separatorInset = .init(top: 0, left: 10, bottom: 0, right: 10)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// MARK: - Init
	
	required init(viewModel: EventsListViewModel,
				  outputHandler: @escaping (EventsListViewController.Output) -> Void) {
		super.init(nibName: nil, bundle: nil)
		
		self.viewModel = viewModel
		self.outputHandler = outputHandler
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Output
	
	enum Output {
		case openDetails(String)
		case fetchError(Error?)
	}
	
	// MARK: - Overrides
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .white
		
		setupView()
		tableView.rx.setDelegate(self).disposed(by: bag)
		
		bindTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		viewModel?.fetchEventsList(finish: { [weak self] error in
			self?.outputHandler?(.fetchError(error))
		})
	}
	
	private func bindTableView() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: EventCell.identifier)
		
		viewModel?.events.bind(to: tableView.rx.items(cellIdentifier: EventCell.identifier, cellType: UITableViewCell.self)) { (row,item,cell) in
			
			if let title = item.title {
				cell.textLabel?.text = title
			}
			
		}.disposed(by: bag)
		
		tableView.rx.modelSelected(Event.self).bind(onNext: { [weak self] item in
			self?.outputHandler?(.openDetails(item.id))
		}).disposed(by: bag)
		
		viewModel?.fetchEventsList(finish: { [weak self] error in
			self?.outputHandler?(.fetchError(error))
		})
	}
}

extension EventsListViewController: ComponentCreation {
	func buildViewHierarchy() {
		self.view.addSubview(tableView)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
		])
	}
	
	func setupAdditionalConfiguration() {
		
	}
}

extension EventsListViewController: UITableViewDelegate {

}

