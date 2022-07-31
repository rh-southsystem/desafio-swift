//
//  EventsListRoute.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit

extension AppCoordinator {
	func showEventsList() {
		let viewModel = EventsListViewModel()
		let vc = EventsListViewController(viewModel: viewModel) { output in
			switch output {
			case .openDetails(let id):
				self.showEventDetailsRoute(id: id)
			case .fetchError(let error):
				self.showError(message: error?.localizedDescription)
			}
		}
		
		DispatchQueue.main.async { [weak self] in
			self?.navigationController = UINavigationController(rootViewController: vc)
			self?.navigationController?.navigationBar.topItem?.title = EAStrings.events.rawValue
			
			self?.window?.rootViewController = self?.navigationController
		}
	}
}
