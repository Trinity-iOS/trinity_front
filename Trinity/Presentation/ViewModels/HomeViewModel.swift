//
//  HomeViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation
import UIKit

class HomeViewModel {
    private let fetchArtworksUseCase: FetchArtworksUseCase

    var artworks: Observable<[Artwork]> = Observable([])
    var pageData: Observable<[Artwork]> = Observable([])
    var error: Observable<Error?> = Observable(nil)

    init(fetchArtworksUseCase: FetchArtworksUseCase) {
        self.fetchArtworksUseCase = fetchArtworksUseCase
    }

    func loadInitialData() {
        fetchArtworksUseCase.execute { [weak self] result in
            switch result {
            case .success(let artworks):
                DispatchQueue.main.async {
                    self?.artworks.value = artworks
                    self?.pageData.value = Array(artworks.prefix(3)) // 첫 3개로 페이지 구성
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error.value = error
                }
            }
        }
    }
}
