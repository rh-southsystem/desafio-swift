//
//  ErrorRoute.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import Foundation
import UIKit

extension AppCoordinator {
	func showError(message: String?) {
		var vc: ErrorViewController?
		
		var errorMsg = EAStrings.weHadAProblem.rawValue
		
		if let message = message {
			errorMsg = message
		}
		
		vc = ErrorViewController(message: errorMsg) { output in
			switch output {
			case .close:
				vc?.dismiss(animated: true, completion: { })
			}
		}
		
		DispatchQueue.main.async {
			if let vc = vc {
				vc.modalPresentationStyle = .fullScreen
				self.navigationController?.present(vc, animated: true, completion: { })
			}
		}
	}
}
