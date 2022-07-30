//
//  ImageHelper.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 30/07/22.
//

import Foundation
import UIKit
import Alamofire

class ImageHelper {
	static var shared = ImageHelper()
	
	func urlImageConverter(url: String?, result: @escaping (Result<Data, Error>) -> Void) {
		
		guard let url = url else { return }
	
		AF.request(url).response {  response in
			switch response.result {
			case .success(let data):
				if let data = data {
					result(.success(data))
				} else {
					result(.failure(CustomError(errorDescription: EAStrings.noDataFound.rawValue)))
				}
				
			case .failure(let error):
				result(.failure(error))
			}
		}
	}
}
