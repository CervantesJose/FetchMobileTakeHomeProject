//
//  ImageCacheFetcher.swift
//  FetchMobileTakeHomeProject
//
//  Created by Jose Cervantes on 6/2/25.
//

import UIKit

actor ImageCacheFetcher {

    private let cacheDirectory: URL

    init() {
        let baseCaches = FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first!
        let imagesCache = baseCaches.appendingPathComponent("Cached Images", isDirectory: true)

        // Create Cached Images folder if it doesn't exist
        if FileManager.default.fileExists(atPath: imagesCache.path) == false {
            try? FileManager.default.createDirectory(
                at: imagesCache,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }

        self.cacheDirectory = imagesCache
    }

    private func fileURL(for url: URL) -> URL {
        let base64 = Data(url.absoluteString.utf8).base64EncodedString()
        let safeName = base64.replacingOccurrences(of: "/", with: "_")

        return cacheDirectory.appendingPathComponent(safeName)
    }

    func loadImage(from url: URL) async throws -> UIImage {
        let localFile = fileURL(for: url)

        // 1) Check disk first
        if FileManager.default.fileExists(atPath: localFile.path),
           let data = try? Data(contentsOf: localFile),
           let image = UIImage(data: data) {
            return image
        }

        // 2) Otherwise, fetch from network and write to disk
        let (data, _) = try await URLSession.shared.data(from: url)
        try? data.write(to: localFile)

        // 3) Decode into UIImage or throw if invalid
        guard let uiImage = UIImage(data: data)
        else { throw URLError(.cannotDecodeContentData) }

        return uiImage
    }
}
