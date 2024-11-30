//
//  MockNetworkingService.swift
//  FetchTakeHome
//
//  Created by Ryan VanAlstine on 11/29/24.
//

@testable import FetchTakeHome
import Foundation

struct Response: Codable {
    let recipes: [Recipe]
}

class MockNetworkingService: NetworkService {
    func fetchRecipes(type: FetchTakeHome.URLType, cursor: String, pageSize: Int) async throws -> [FetchTakeHome.Recipe] {
        let jsonString = """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photo_url_large": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
                },
                {
                    "cuisine": "British",
                    "name": "Apple & Blackberry Crumble",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                    "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                    "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                },
                {
                    "cuisine": "British",
                    "name": "Apple Frangipan Tart",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
                    "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
                    "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
                },
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "youtube_url": "https://www.youtube.com/watch?v=1ahpSTf_Pvk"
                },
                {
                    "cuisine": "American",
                    "name": "Banana Pancakes",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/banana-pancakes",
                    "uuid": "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                    "youtube_url": "https://www.youtube.com/watch?v=kSKtb2Sv-_U"
                }
            ]
        }
        """

        let data = jsonString.data(using: .utf8) ?? Data()
        let res = try JSONDecoder().decode(Response.self, from: data)
        return res.recipes
    }
}
