//
//  RecipeRowView.swift
//  FetchMobileTakeHomeProject
//
//  Created by Jose Cervantes on 6/2/25.
//

import SwiftUI

struct RecipeRowView: View {

    let recipe: Recipe

    @State private var uiImage: UIImage?
    @State private var isLoading = false
    @State private var loadError: Error?

    private let fetcher = ImageCacheFetcher()

    var body: some View {

        HStack {

            imageView()
            VStack(alignment: .leading) {
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .lineLimit(1)
                Text(recipe.name)
                    .font(.headline)
                    .lineLimit(1)
            }
        }
    }

    @ViewBuilder
    private func imageView() -> some View {
        if let image = uiImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 4))
        } else if isLoading {
            ProgressView()
                .frame(width: 44, height: 44)
        } else if loadError != nil {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
        } else {
            Color.clear
                .frame(width: 44, height: 44)
                .onAppear {
                    Task {
                        await loadImage()
                    }
                }
        }
    }

    private func loadImage() async {
        guard uiImage == nil, !isLoading else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            uiImage = try await fetcher.loadImage(from: recipe.photoURLSmall!)
        } catch {
            loadError = error
        }
    }
}
