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
				break
			}
		}
		
		DispatchQueue.main.async {
			self.window?.rootViewController = vc
		}
	}
}
