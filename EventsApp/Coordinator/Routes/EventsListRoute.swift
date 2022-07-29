//
//  EventsListRoute.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit

extension AppCoordinator {
	func showEventsList() {
		let vc = EventsListViewController()
		
		DispatchQueue.main.async {
			self.window?.rootViewController = vc
		}
	}
}
