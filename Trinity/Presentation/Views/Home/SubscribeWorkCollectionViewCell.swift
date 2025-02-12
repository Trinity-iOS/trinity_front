//
//  SubscribeWorkCollectionViewCell.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//


import UIKit
import SnapKit

class SubscribeWorkCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "subscribeWorkCell"

    var deleteHandler: (() -> Void)?
    var artworkID: String = ""

    // UI Components
    private lazy var artworkImage: UIImageView = createArtworkImage()
    private lazy var artworkNicknameLabel: UILabel = createArtworkNicknameLabel()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupUI() {
        addSubview(artworkImage)
        addSubview(artworkNicknameLabel)

        setupLayout()
    }

    private func setupLayout() {
        artworkImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 32)
            make.centerX.equalToSuperview()
        }

        artworkNicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(artworkImage.snp.bottom).offset(8)
            make.leading.equalTo(artworkImage)
        }
    }

    // MARK: - Configure Cell
    func configure(with artwork: Artwork) {
        artworkID = artwork.id
        artworkImage.image = artwork.image
        artworkNicknameLabel.text = artwork.artist

        adjustImageHeight(for: artwork.image)
    }

    private func adjustImageHeight(for image: UIImage) {
        let ratio = image.size.height / image.size.width
        let artworkImageWidth = UIScreen.main.bounds.width - 32
        let calculatedHeight = artworkImageWidth * ratio

        artworkImage.snp.updateConstraints { make in
            make.height.equalTo(calculatedHeight)
        }
    }
}

// MARK: - Helpers
extension SubscribeWorkCollectionViewCell {
    private func createArtworkImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }

    private func createArtworkNicknameLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Moderniz", size: 16)
        label.textColor = .black
        return label
    }
}
