//
//  Movie.swift
//  CompleteTheMovieTitle
//
//  Created by Osama Gamal on 25/05/2021.
//

import Foundation

public struct Movie: Codable {
    public let name: String // Movie name will always be more than one word
    public let image: String // The local image name
    public let wrongAnswers: [String] // Will always be 3 items
    
    enum CodingKeys: String, CodingKey {
        case name
        case image
        case wrongAnswers = "wrong_answers"
    }
}
