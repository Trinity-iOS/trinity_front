//
//  ArtworkRepository.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation

protocol ArtworkRepository {
    func fetchArtworks(completion: @escaping (Result<[Artwork], Error>) -> Void)
}
