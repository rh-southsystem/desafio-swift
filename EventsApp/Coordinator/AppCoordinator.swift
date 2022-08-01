//
//  AppCoordinator.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit

class AppCoordinator: NSObject {
	
	private(set) var window: UIWindow?
	var navigationController: UINavigationController?
	
	init(window: UIWindow?) {
		super.init()
		
		self.window = window
		window?.makeKeyAndVisible()
		
		showEventsList()
	}
}
