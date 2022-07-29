//
//  EventDetailsViewController.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit

class EventDetailsViewController: UIViewController {

	private var viewModel: EventDetailsViewModelProtocol?
	private var outputHandler: ((EventDetailsViewController.Output) -> Void)?
	
	required init(viewModel: EventDetailsViewModelProtocol,
				  outputHandler: @escaping (EventDetailsViewController.Output) -> Void) {
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
		
		self.view.backgroundColor = .systemRed
    }
	
	enum Output {
		case close
	}
}
