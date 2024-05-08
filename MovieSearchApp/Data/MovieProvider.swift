//
//  MovieProvider.swift
//  MovieSearchApp
//
//  Created by Mañanas on 8/5/24.
//

import Foundation

class MovieProvider {
    
    static let baseURL = "https://www.omdbapi.com/?apikey=7a9f860d"
    
    static func getMovies(_ byTitle: String) async throws -> [Movie] {
        let keySearch:String = "&s="
        let titleLowercased = byTitle.lowercased()
        let movies = try await fetchMoviesFromAPI(keySearch, title: titleLowercased)
        return movies
    }
    
    static func getMovie(_ byID:String) async throws -> MovieDetail {
        let movie = try await fetchMoviesFromAPI(byID)
        return movie
    }
    
    //To make the call and obtain data from the API REST
    static func fetchMoviesFromAPI(_ keySearch: String, title: String) async throws -> [Movie] {
        //Error handling to ensure URL is valid
        guard let url = URL(string: baseURL + keySearch + title) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let decode = try JSONDecoder().decode(MovieResponse.self, from: data)
            return decode.Search
        } catch {
            throw error
        }
    }
    
    static func fetchMoviesFromAPI(_ byID: String) async throws -> MovieDetail {
        //Error handling to ensure URL is valid
        guard let url = URL(string: baseURL + "&i=" + byID) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        print(url)
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let decode = try JSONDecoder().decode(MovieDetail.self, from: data)
            return decode
        } catch {
            throw error
        }
    }
    
    
}
