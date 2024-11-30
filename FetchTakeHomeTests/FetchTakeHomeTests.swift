//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Ryan VanAlstine on 11/29/24.
//

@testable import FetchTakeHome
import XCTest

@MainActor
final class FetchTakeHomeTests: XCTestCase {
    var apiClient: FetchNetworkingService!
    var recipeListViewModel: RecipeListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        apiClient = FetchNetworkingService()
        recipeListViewModel = RecipeListViewModel(networkService: apiClient)
    }

    override func tearDownWithError() throws {
        apiClient = nil
        recipeListViewModel = nil
        try super.tearDownWithError()
    }

    func testFetchRecipes() async {
        do {
            let recipes = try await apiClient.fetchRecipes(type: .default)
            XCTAssertTrue(!recipes.isEmpty)
        } catch {
            XCTFail("Recipe fetch failed: \(error)")
        }
    }

    func testResultsSortedAscendingByDefault() async {
        await recipeListViewModel.fetchRecipes()
        XCTAssertTrue(!recipeListViewModel.recipes.isEmpty)
        XCTAssertEqual(recipeListViewModel.recipes, recipeListViewModel.recipes.sorted(by: { $0.name < $1.name }))
    }

    func testResultsSortedDescending() async {
        await recipeListViewModel.fetchRecipes()
        recipeListViewModel.toggleSort()
        XCTAssertTrue(!recipeListViewModel.recipes.isEmpty)
        XCTAssertEqual(recipeListViewModel.recipes, recipeListViewModel.recipes.sorted(by: { $0.name > $1.name }))
    }
}
