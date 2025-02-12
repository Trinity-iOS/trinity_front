//
//  FetchArtworkUseCase.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation


class FetchArtworksUseCase {
    private let repository: ArtworkRepository

    init(repository: ArtworkRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[Artwork], Error>) -> Void) {
        repository.fetchArtworks(completion: completion)
    }
}
