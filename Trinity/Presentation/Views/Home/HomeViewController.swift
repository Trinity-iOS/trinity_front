//
//  HomeViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import UIKit

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    private let layout: HomeViewLayout

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.layout = HomeViewLayout()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.loadInitialData()
    }

    private func setupBindings() {
        viewModel.artworks.bind { [weak self] artworks in
            self?.layout.updateCollectionView(with: artworks)
        }

        viewModel.pageData.bind { [weak self] pageData in
            self?.layout.updatePageView(with: pageData)
        }
    }
}
