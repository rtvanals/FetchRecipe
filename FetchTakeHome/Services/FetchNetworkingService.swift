//
//  FetchNetworkingService.swift
//  FetchTakeHome
//
//  Created by Ryan VanAlstine on 11/27/24.
//

import Foundation

public enum URLType: String {
    case `default` = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    case empty = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    case malformed = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
}

public protocol NetworkService {
    // Comment: I added a cursor and page size to the fetch protocol even though the API doesn't support it just to illustrate where we would put pagination data for an API call.
    
    func fetchRecipes(
        type: URLType,
        cursor: String,
        pageSize: Int
    ) async throws -> [Recipe]
}

public final class FetchNetworkingService: NetworkService {
    public func fetchRecipes(
        type: URLType = .default,
        cursor: String = "",
        pageSize: Int = 50
    ) async throws -> [Recipe] {
        guard let url = URL(string: type.rawValue) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        // Comment: Just for brevity, I'm creating a "temporary" struct here to make codable work.
        // I would normally build out a full model for the response.
        struct Response: Codable {
            let recipes: [Recipe]
        }

        #if DEBUG
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        #endif

        let res = try JSONDecoder().decode(Response.self, from: data)
        return res.recipes
    }
}
