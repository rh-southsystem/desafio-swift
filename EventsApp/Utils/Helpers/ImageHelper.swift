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
	
	func urlImageConverter(url: String?) -> UIImage? {
		var image: UIImage?
		
		guard let url = url else { return UIImage() }
		
		AF.request(url).response {  response in
			switch response.result {
			case .success(let data):
				if let data = data {
					image = UIImage(data: data)
				}
				
			case .failure(_):
				image = UIImage()
			}
		}
		
		return image
	}
}
