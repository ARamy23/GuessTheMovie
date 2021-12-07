//
//  MoviesEndpoint.swift
//  GuessTheMovie
//
//  Created by Ahmed Ramy on 07/12/2021.
//

import Foundation

enum MoviesEndpoint: Endpoint {
    case fetchMovies
}

extension MoviesEndpoint {
    var path: String {
        "complete-movie-title.json"
    }
    
    var parameters: HTTPParameters {
        [:]
    }
    
    var method: HTTPMethod {
        [:]
    }
}
