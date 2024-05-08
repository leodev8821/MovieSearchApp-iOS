//
//  MovieResponse.swift
//  MovieSearchApp
//
//  Created by Mañanas on 8/5/24.
//

import Foundation

struct MovieResponse: Decodable {
    let Search: [Movie]
}

struct Movie : Decodable {
    let Title:String?
    let Year:String?
    let imdbID:String?
    let Poster:String?
}

struct MovieDetail: Decodable {
    let Title:String?
    let Year:String?
    let Poster:String?
    let Plot:String?
    let Runtime:String?
    let Director:String?
    let Genre:String?
    let Country:String?
}
