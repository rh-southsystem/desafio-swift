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
		
		let vc = EventDetailsViewController(viewModel: viewModel) { output in
			switch output {
			case .close:
				break
			}
		}
		
		DispatchQueue.main.async {
			vc.modalPresentationStyle = .fullScreen
			
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
}
