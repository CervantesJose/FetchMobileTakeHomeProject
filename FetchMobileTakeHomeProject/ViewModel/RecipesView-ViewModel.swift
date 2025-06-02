//
//  RecipesView-ViewModel.swift
//  FetchMobileTakeHomeProject
//
//  Created by Jose Cervantes on 6/2/25.
//

import Foundation


private enum Constants {
    static let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
}

extension RecipesView {

    @MainActor
    class ViewModel: ObservableObject {

        @Published var recipes: [Recipe] = []
        let networkManager: NetworkService

        init(networkManager: NetworkService = NetworkManager(url: URL(string: Constants.urlString))) {
            self.networkManager = networkManager
        }

        func fetchRecipes() async throws -> [Recipe] {
            let response: RecipesResponse = try await networkManager.fetchData()
            recipes = response.recipes
            return recipes
        }
    }
}
