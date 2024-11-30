//
//  RecipeCard.swift
//  FetchTakeHome
//
//  Created by Ryan VanAlstine on 11/28/24.
//

import Kingfisher
import SwiftUI

public struct RecipeCard: View {
    private let recipe: Recipe

    public init(recipe: Recipe) {
        self.recipe = recipe
    }

    public var body: some View {
        // Comment: This could also be done with a ZStack rather than an image view with mulitple overlays.  I tend to prefer using
        // overlays when placing elements on top of an image because they work a little better with SwiftUI Previews.

        // Comment: Kingfisher handles the caching for us. If we don't want to use a package we could implement our our cache
        // using NSCache or storing them ourselves using the url string as the key.
        
        KFImage(recipe.photoURL)
            .placeholder { _ in
                Color.gray.opacity(0.3)
            }
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .overlay {
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            .clear,
                            .clear,
                            .black.opacity(0.7),
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .overlay(alignment: .topTrailing) {
                HStack(spacing: 0) {
                    Spacer()
                    // Comment: If the recipe source URL is not missing/malformed and we are on a device that can open a URL, show the button
                    if let sourceURL = recipe.sourceURL,
                       UIApplication.shared.canOpenURL(sourceURL) {
                        Button {
                            UIApplication.shared.open(sourceURL, options: [:], completionHandler: nil)
                        } label: {
                            Image(systemName: "link")
                                .font(.system(size: 24))
                                .foregroundStyle(.white)
                                .padding()
                                .shadow(color: .black, radius: 5)
                        }
                    }

                    // Comment: If the Youtube URL is not missing/malformed and we are on a device that can open a youtube URL, show the button
                    if let youtubeURL = recipe.youtubeURL,
                       UIApplication.shared.canOpenURL(youtubeURL) {
                        Button {
                            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
                        } label: {
                            Image("youtube")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                                .padding()
                        }
                    }
                }
                .padding(8)
            }
            .overlay(alignment: .bottomLeading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 24, weight: .semibold))

                        Text(recipe.cuisine)
                            .font(.system(size: 18))
                    }
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)

                    Spacer()
                }
                .padding(8)
            }
    }
}

public struct RecipeCardViewPreview: PreviewProvider {
    // Comment: Typcially, each one of these previews would contain something different that we need to test
    // For instance, a missing link, or long/truncated text.
    
    static var apamBalik: some View {
        RecipeCard(recipe: .apamBalik)
            .previewDisplayName("Apam Balik")
    }
    
    static var appleCrumble: some View {
        RecipeCard(recipe: .appleCrumble)
            .previewDisplayName("Apple Cumble")
    }
    
    static var appleTart: some View {
        RecipeCard(recipe: .appleTart)
            .previewDisplayName("Apple Tart")
    }
    
    static var peanutButterCookie: some View {
        RecipeCard(recipe: .peanutButterCookie)
            .previewDisplayName("Peanut Butter Cookie")
    }

    public static var previews: some View {
        return Group {
            apamBalik
            appleCrumble
            appleTart
            peanutButterCookie
        }
    }
}
