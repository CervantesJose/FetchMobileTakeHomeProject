//
//  FetchMobileTakeHomeProjectTests.swift
//  FetchMobileTakeHomeProjectTests
//
//  Created by Jose Cervantes on 6/2/25.
//

import Testing
@testable import FetchMobileTakeHomeProject

@Suite
struct FetchMobileTakeHomeProjectTests {

    @Test("Fetch recipes success")
    static func fetchRecipes() async throws {
        // Given
        let viewModel = await RecipesView.ViewModel()

        // When
        let recipes = try await viewModel.fetchRecipes()

        // Then
        #expect(recipes.count > 0)
    }

    @Test("Caching Image")
    static func loadImage() async throws {
        // Given
        let viewModel = await RecipesView.ViewModel()

        // When
        let imageData = try await viewModel.fetchRecipes()[0].photoURLSmall

        // Then
        #expect(imageData?.absoluteString.contains("https") ?? false)
    }

}
