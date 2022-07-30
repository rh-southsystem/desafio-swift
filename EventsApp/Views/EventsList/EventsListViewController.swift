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
		
		bindTableView()
		addLoadingSubscribe()
	}
}

private extension EventsListViewController {
	func bindTableView() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		
		viewModel?.events.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row,item,cell) in
			
			if let title = item.title {
				cell.textLabel?.text = title
				cell.selectionStyle = .none
			}
			
		}.disposed(by: bag)
		
		tableView.rx.modelSelected(EventJSON.self).bind(onNext: { [weak self] item in
			self?.outputHandler?(.openDetails(item.id))
		}).disposed(by: bag)
		
		viewModel?.fetchEventsList(finish: { [weak self] error in
			self?.outputHandler?(.fetchError(error))
		})
	}
	
	@objc func didPullToRefresh() {
		viewModel?.fetchEventsList(finish: { [weak self] error in
			if let error = error {
				self?.outputHandler?(.fetchError(error))
			}
		})
	}
	
	func addLoadingSubscribe() {
		viewModel?.loading.subscribe({ [weak self] newValue in
			if newValue.element == true {
				self?.tableView.refreshControl?.beginRefreshing()
			} else {
				self?.tableView.refreshControl?.endRefreshing()
			}
		}).disposed(by: bag)
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
		tableView.rx.setDelegate(self).disposed(by: bag)
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
	}
}

extension EventsListViewController: UITableViewDelegate {

}

