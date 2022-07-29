//
//  EventsListViewController.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 28/07/22.
//

import UIKit

class EventsListViewController: UIViewController {
	
	private var viewModel: EventsListViewModelProtocol?
	private var outputHandler: ((EventsListViewController.Output) -> Void)?

	required init(viewModel: EventsListViewModelProtocol,
				  outputHandler: @escaping (EventsListViewController.Output) -> Void) {
		super.init(nibName: nil, bundle: nil)
		
		self.viewModel = viewModel
		self.outputHandler = outputHandler
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.view.backgroundColor = .cyan
	}
	
	enum Output {
		case openDetails(String)
	}
}

