//
//  HomeViewLayout.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import UIKit
import SnapKit

class HomeViewLayout: UIView {
    let collectionView: UICollectionView
    let pageViewController: UIPageViewController
    let pageControl: UIPageControl

    override init(frame: CGRect) {
        // UI Components 초기화
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageControl = UIPageControl()

        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        backgroundColor = .white
        setupPageView()
        setupCollectionView()
        setupPageControl()
    }

    private func setupPageView() {
        addSubview(pageViewController.view)
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(SubscribeWorkCollectionViewCell.self, forCellWithReuseIdentifier: SubscribeWorkCollectionViewCell.identifier)

        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(pageViewController.view.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupPageControl() {
        addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(pageViewController.view.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }

    // 데이터 업데이트 메서드
    func updateCollectionView(with artworks: [Artwork]) {
        // 업데이트된 데이터로 UI 갱신
        collectionView.reloadData()
    }

    func updatePageView(with pages: [Artwork]) {
        guard let firstPage = pages.first else { return }
        let firstVC = HomePageViewController(artworkData: firstPage)
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
    }
}
