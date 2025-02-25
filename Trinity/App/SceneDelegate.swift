//
//  SceneDelegate.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        let loginViewController = DIContainer.makeLoginViewController() // DI 컨테이너 사용
        let DIContainer = DIContainer()
        let interestVC = DIContainer.makeInerestViewController()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: interestVC)
        self.window = window
        window.makeKeyAndVisible()
    }
    
    //    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    //
    //        // 네비게이션 바 Appearance 설정
    //        let appearance = UINavigationBarAppearance()
    //        appearance.backgroundColor = UIColor.IFBgDef
    //        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    //        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    //
    //        UINavigationBar.appearance().standardAppearance = appearance
    //        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    //
    //        // Scene 설정
    //        guard let windowScene = (scene as? UIWindowScene) else { return }
    //
    //        let repository: ArtworkRepository = MockArtworkRepository() // 실제 API를 사용할 땐 ArtworkRepositoryImpl(apiClient: apiClient)
    //            let fetchArtworksUseCase = FetchArtworksUseCase(repository: repository)
    //            let homeViewModel = HomeViewModel(fetchArtworksUseCase: fetchArtworksUseCase)
    //
    //        // 각 ViewController 생성 및 DI 주입
    //        let homeVC = HomeViewController(viewModel: homeViewModel)
    //        let discoverVC = HomeViewController(viewModel: homeViewModel)
    //        let boardVC = HomeViewController(viewModel: homeViewModel)
    //        let myPageVC = HomeViewController(viewModel: homeViewModel)
    //
    //        let tabBarVC = TabBarViewController(
    //            homeVC: homeVC,
    //            discoverVC: discoverVC,
    //            boardVC: boardVC,
    //            myPageVC: myPageVC
    //        )
    //
    //        // Window 설정
    //        let window = UIWindow(windowScene: windowScene)
    //        window.rootViewController = tabBarVC
    //        self.window = window
    //        window.makeKeyAndVisible()
    //    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
    }
}
