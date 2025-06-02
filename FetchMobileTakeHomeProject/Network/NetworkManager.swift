//
//  NetworkManager.swift
//  FetchMobileTakeHomeProject
//
//  Created by Jose Cervantes on 6/2/25.
//

import Foundation

protocol NetworkService {
    func fetchData<T: Decodable>() async throws -> T
}

struct NetworkManager: NetworkService {
    let url: URL?

    init(url: URL?) {
        self.url = url
    }

    func fetchData<RecipesResponse: Decodable>() async throws -> RecipesResponse {
        guard let url else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(RecipesResponse.self, from: data)
    }
}
