//
//  HomePageViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//


import UIKit
import CoreImage

protocol HomePageViewControllerDelegate: AnyObject {
    func showHighlightedImage(image: UIImage)
    func hideHighlightedImage()
}

class HomePageViewController: UIViewController {
    // MARK: - Properties
    let artworkData: Artwork
    weak var delegate: HomePageViewControllerDelegate?

    // UI Components
    lazy var button: UIButton = createButton()

    // MARK: - Initializer
    init(artworkData: Artwork) {
        self.artworkData = artworkData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = UIColor.IFBgDef
        view.addSubview(button)
        setupLayout()
    }

    private func setupLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Actions
extension HomePageViewController {
    @objc func buttonTapped(_ sender: UIButton) {
//        navigateToArtworkDetail()
    }

    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        handleLongPressGesture(gesture)
    }
}

// MARK: - Helpers
extension HomePageViewController {
    private func createButton() -> UIButton {
        let button = UIButton()
        button.setImage(artworkData.image.convertToGrayscale(), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        button.addGestureRecognizer(longPressGesture)

        return button
    }

//    private func navigateToArtworkDetail() {
//        let artworkVC = ArtworkViewController()
//        artworkVC.artworkID = artworkData.id
//        artworkVC.hidesBottomBarWhenPushed = true
//
//        navigationController?.pushViewController(artworkVC, animated: true)
//    }

    private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            delegate?.showHighlightedImage(image: artworkData.image)
        case .ended, .cancelled:
            delegate?.hideHighlightedImage()
        default:
            break
        }
    }
}
