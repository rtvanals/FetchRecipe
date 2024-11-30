//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Ryan VanAlstine on 11/27/24.
//
import Foundation

public struct Recipe: Identifiable, Equatable, Codable {
    public let id: String
    public let cuisine: String
    public let name: String
    public let photoURLStringLarge: String?
    public let photoURLStringSmall: String?
    public let sourceURLString: String?
    public let youtubeURLString: String?

    var photoURL: URL? {
        guard let photoURLStringLarge else { return nil }
        return URL(string: photoURLStringLarge)
    }

    var youtubeURL: URL? {
        guard let youtubeURLString else { return nil }
        return URL(string: youtubeURLString)
    }

    var sourceURL: URL? {
        guard let sourceURLString else { return nil }
        return URL(string: sourceURLString)
    }

    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoURLStringLarge = "photo_url_large"
        case photoURLStringSmall = "photo_url_small"
        case sourceURLString = "source_url"
        case youtubeURLString = "youtube_url"
    }
}

// MARK: - Stubs

// Comment: These could be put into a json file or built a little differently but I like to put the mock preview data in the model file because I tend to modify it
// frquently when building UI and its easy to find when included in the model.
extension Recipe {
    public static let apamBalik = Recipe(
        id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
        cuisine: "Malaysian",
        name: "Apam Balik",
        photoURLStringLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        photoURLStringSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        sourceURLString: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
        youtubeURLString: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
    )

    public static let appleCrumble = Recipe(
        id: "599344f4-3c5c-4cca-b914-2210e3b3312f",
        cuisine: "British",
        name: "Apple & Blackberry Crumble But Adding More Text To Test Out Wrapping Text Or Truncated Text",
        photoURLStringLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
        photoURLStringSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
        sourceURLString: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
        youtubeURLString: "https://www.youtube.com/watch?v=4vhcOwVBDO4"
    )

    public static let appleTart = Recipe(
        id: "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
        cuisine: "British",
        name: "Apple Frangipan Tart",
        photoURLStringLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
        photoURLStringSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
        sourceURLString: nil,
        youtubeURLString: "https://www.youtube.com/watch?v=rp8Slv4INLk"
    )

    public static let peanutButterCookie = Recipe(
        id: "6b546d86-aaa6-47ff-a4e4-49836392f9b0",
        cuisine: "American",
        name: "Peanut Butter Cookies",
        photoURLStringLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/fa8fca0d-fd72-4f84-937d-2db66739f5b4/large.jpg",
        photoURLStringSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/fa8fca0d-fd72-4f84-937d-2db66739f5b4/small.jpg",
        sourceURLString: "https://tasty.co/recipe/3-ingredient-peanut-butter-cookies",
        youtubeURLString: nil
    )

    public static let allMocks: [Recipe] = [
        apamBalik,
        appleCrumble,
        appleTart,
        peanutButterCookie,
    ]
}
