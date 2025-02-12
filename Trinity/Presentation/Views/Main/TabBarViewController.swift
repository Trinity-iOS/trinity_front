//
//  TabBarViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    private let homeViewController: UIViewController
    private let discoverViewController: UIViewController
    private let boardViewController: UIViewController
    private let myPageViewController: UIViewController

    // Dependency Injection으로 ViewControllers를 주입받음
    init(
        homeVC: UIViewController,
        discoverVC: UIViewController,
        boardVC: UIViewController,
        myPageVC: UIViewController
    ) {
        self.homeViewController = homeVC
        self.discoverViewController = discoverVC
        self.boardViewController = boardVC
        self.myPageViewController = myPageVC
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        configureTabs()
        self.delegate = self
    }

    private func setupCustomTabBar() {
        self.setValue(CustomTabBar(), forKey: "tabBar")

        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.IFBgDef
        appearance.shadowImage = nil
        appearance.shadowColor = .clear
        appearance.backgroundImage = UIImage()
        appearance.backgroundEffect = nil
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]
        appearance.stackedLayoutAppearance.normal.iconColor = .gray

        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        }
    }

    private func configureTabs() {
        // 탭 설정
        viewControllers = [
            createNavController(for: homeViewController, title: "Home", imageName: "tab_home"),
            createNavController(for: discoverViewController, title: "Discover", imageName: "tab_discover"),
            createNavController(for: boardViewController, title: "Board", imageName: "tab_board"),
            createNavController(for: myPageViewController, title: "MyPage", imageName: "tab_myPage")
        ]
        selectedIndex = 0
    }

    private func createNavController(for rootViewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let image = UIImage(named: imageName)?.resize(to: CGSize(width: 28, height: 28))
        rootViewController.tabBarItem = UITabBarItem(title: "", image: image, selectedImage: nil)
        return UINavigationController(rootViewController: rootViewController)
    }
}
