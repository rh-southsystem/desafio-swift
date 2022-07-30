//
//  EventDetailsRoute.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import Foundation

extension AppCoordinator {
	func showEventDetailsRoute(id: String) {
		let viewModel = EventDetailsViewModel(id: id)
		var vc: EventDetailsViewController?
		vc = EventDetailsViewController(viewModel: viewModel) { output in
			switch output {
			case .close:
				DispatchQueue.main.async {
					vc?.dismiss(animated: true, completion: { })
				}
			}
		}
		
		DispatchQueue.main.async {
			vc?.modalPresentationStyle = .fullScreen
			if let vc = vc {
				self.navigationController?.pushViewController(vc, animated: true)
			}
		}
	}
}
