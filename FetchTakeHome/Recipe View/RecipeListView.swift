//
//  RecipeListView.swift
//  FetchTakeHome
//
//  Created by Ryan VanAlstine on 11/27/24.
//

import SwiftUI

public struct RecipeListView: View {
    @ObservedObject private var viewModel: RecipeListViewModel
    @State private var showEndpointSheet = false

    private let columns = [
        // GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
    ]
    // Comment: We could add another one or two grid items above if we want more than one recipe per row.

    public init(viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .default:
                    if viewModel.recipes.isEmpty {
                        EmptyStateView(viewType: .recipes)
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                                ForEach(viewModel.recipes, id: \.id) { recipe in
                                    RecipeCard(recipe: recipe)
                                        .padding(.vertical, 4)
                                }
                            }
                        }

                        .padding(.horizontal, 8)
                        .refreshable {
                            await viewModel.fetchRecipes()
                        }
                        .searchable(
                            text: $viewModel.searchText,
                            placement: .navigationBarDrawer(displayMode: .always),
                            prompt: "Search by name or cuisine"
                        )

                    }
                case .processing:
                    ProgressView()
                        .padding()

                    Spacer()
                case .error:
                    ErrorStateView(viewType: .recipes)
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        showEndpointSheet.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundStyle(.black)
                    }

                    Button {
                        viewModel.toggleSort()
                    } label: {
                        let image = viewModel.isSortedAscending ? "arrow.up.arrow.down.circle.fill" : "arrow.up.arrow.down.circle"
                        Image(systemName: image)
                            .foregroundStyle(.black)
                    }
                }
            }
            .confirmationDialog("Test the URL",
                                isPresented: $showEndpointSheet,
                                titleVisibility: .visible) {
                Button("Default") {
                    viewModel.urlType = .default
                    showEndpointSheet.toggle()
                }
                Button("Empty") {
                    viewModel.urlType = .empty
                    showEndpointSheet.toggle()
                }
                Button("Malformed") {
                    viewModel.urlType = .malformed
                    showEndpointSheet.toggle()
                }
            }
            .task {
                await viewModel.fetchRecipes(animate: true)
            }
        }
    }
}

#Preview {
    RecipeListView(
        viewModel: .init(
            networkService: .init(),
            recipes: Recipe.allMocks
        )
    )
}
