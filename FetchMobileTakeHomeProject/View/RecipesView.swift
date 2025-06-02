//
//  RecipesView.swift
//  FetchMobileTakeHomeProject
//
//  Created by Jose Cervantes on 6/2/25.
//

import SwiftUI

struct RecipesView: View {

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeRowView(recipe: recipe)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .navigationTitle("Fetch Recipes")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .task {
                do {
                    viewModel.recipes = try await viewModel.fetchRecipes()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    RecipesView()
}
