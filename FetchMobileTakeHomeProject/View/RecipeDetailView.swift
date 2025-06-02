//
//  RecipeDetailView.swift
//  FetchMobileTakeHomeProject
//
//  Created by Jose Cervantes on 6/2/25.
//

import SwiftUI

struct RecipeDetailView: View {

    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack {
                Text(recipe.name)
                    .font(.title)
                Text(recipe.cuisine)
                    .font(.subheadline)
                AsyncImage(url: recipe.photoURLLarge) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("There was an error loading the image.")
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 200, height: 200)
            }

            VStack(alignment: .leading) {
                if let sourceURL = recipe.sourceURL {
                    Text("Source\n \(sourceURL)")
                }
                if let youtubeURL = recipe.youtubeURL {
                    Text("YouTube\n \(youtubeURL)")
                }
            }
        }
    }
}

#Preview {
    RecipeDetailView(
        recipe: Recipe(
            id: "",
            name: "Chilaquiles",
            cuisine: "Mexican",
            photoURLLarge: nil,
            photoURLSmall: nil,
            sourceURL: nil,
            youtubeURL: nil
        )
    )
}
