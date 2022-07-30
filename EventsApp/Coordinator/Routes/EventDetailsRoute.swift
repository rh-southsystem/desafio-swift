//
//  EventDetailsRoute.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import Foundation

extension AppCoordinator {
	func showEventDetailsRoute() {
		let viewModel = EventDetailsViewModel()
		
		let vc = EventDetailsViewController(viewModel: viewModel) { output in
			switch output {
			case .close:
				break
			}
		}
		
		DispatchQueue.main.async {
			self.window?.rootViewController = vc
		}
	}
}
