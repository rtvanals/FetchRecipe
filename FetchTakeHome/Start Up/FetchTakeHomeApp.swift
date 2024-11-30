//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Ryan VanAlstine on 11/27/24.
//

import SwiftUI

@main
struct FetchTakeHomeApp: App {
    let networkService: FetchNetworkingService = .init()
    
    var body: some Scene {
        WindowGroup {
            // Comment: I would typcially create a router or root view model depending on the use case.
            // I would do this so that we can route to a particular view from a push notification or univeral link.
            // Also, if we needed any logic to happen that would apply across all views in the app, we could put that in the router/root view.
            // For instance, if we need to refresh an access token, show a maintenance screen, or fetch some remote config values upon launch, we
            // could put it in there and build the UI accordingly.
            
            RecipeListView(viewModel: .init(networkService: networkService))
        }
    }
}
