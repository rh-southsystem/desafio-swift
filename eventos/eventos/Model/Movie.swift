//
//  Movies.swift
//  eventos
//
//  Created by Enrique Dutra on 08/01/21.
//

import Foundation

public struct Movie: Codable, Identifiable{
    public var id: Int
    
    let name: String
    let imageURL: String
}



