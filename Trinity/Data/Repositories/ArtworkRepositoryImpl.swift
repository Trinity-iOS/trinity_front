//
//  ArtworkRepositoryImpl.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation

class ArtworkRepositoryImpl: ArtworkRepository {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchArtworks(completion: @escaping (Result<[Artwork], Error>) -> Void) {
        // API 연동 예시 (현재 주석 처리)
        // apiClient.request(endpoint: .fetchArtworks) { (result: Result<[Artwork], Error>) in
        //     completion(result)
        // }

        // 현재는 Mock 데이터를 반환
        completion(.success(MockData.artworkItems))
    }
}
