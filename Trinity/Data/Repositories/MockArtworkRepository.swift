//
//  MockArtworkRepository.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation

class MockArtworkRepository: ArtworkRepository {
    func fetchArtworks(completion: @escaping (Result<[Artwork], Error>) -> Void) {
        completion(.success(MockData.artworkItems)) // MockData를 반환
    }
}

