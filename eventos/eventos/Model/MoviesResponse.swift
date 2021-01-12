//
//  MoviesResponse.swift
//  eventos
//
//  Created by Enrique Dutra on 11/01/21.
//

import Foundation

public struct MoviesResponse: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}
