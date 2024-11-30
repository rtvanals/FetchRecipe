//
//  RecipeListViewModel.swift
//  FetchTakeHome
//
//  Created by Ryan VanAlstine on 11/27/24.
//
import SwiftUI

@MainActor
public final class RecipeListViewModel: ObservableObject {
    public enum ViewState {
        case `default`  // Our API returned without an error
        case processing // Our API is processing
        case error // There was an error
    }

    @Published public private(set) var recipes: [Recipe]
    @Published public private(set) var showHUD: Bool = false
    @Published public private(set) var isSortedAscending: Bool = false
    @Published public private(set) var viewState: ViewState = .default
    @Published public var searchText: String = "" {
        didSet {
            searchRecipes()
        }
    }

    public var urlType: URLType = .default {
        didSet {
            Task {
                await fetchRecipes(animate: true)
            }
        }
    }

    private let networkService: FetchNetworkingService
    private var allRecipes: [Recipe] = []

    init(
        networkService: FetchNetworkingService,
        recipes: [Recipe] = []
    ) {
        self.networkService = networkService
        self.recipes = recipes
    }

    public func fetchRecipes(animate: Bool = false) async {
        if animate { viewState = .processing }

        do {
            recipes = try await networkService.fetchRecipes(type: urlType)
            sortRecipeList()
            
            allRecipes = recipes
            viewState = .default
            
        } catch {
            print(error)
            viewState = .error
        }
    }

    public func toggleSort() {
        isSortedAscending.toggle()
        sortRecipeList()
    }
}

extension RecipeListViewModel {
    private func sortRecipeList() {
        if isSortedAscending {
            recipes.sort(by: { $0.name > $1.name })
        } else {
            recipes.sort(by: { $0.name < $1.name })
        }
    }

    private func searchRecipes() {
        if searchText.isEmpty {
            recipes = allRecipes
            return
        }

        recipes = allRecipes.filter({
            $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.cuisine.lowercased().contains(searchText.lowercased())
        })
    }
}
