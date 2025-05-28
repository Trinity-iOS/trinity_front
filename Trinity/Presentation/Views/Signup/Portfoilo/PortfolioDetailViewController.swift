import UIKit
import SwiftUI

class PortfolioDetailViewController: UIViewController {
    
    private let viewModel: PortfolioDetailViewModelProtocol
    private let diContainer: DIContainer
    
    // MARK: - Initializer
    init(viewModel: PortfolioDetailViewModelProtocol, diContainer: DIContainer) {
        self.viewModel = viewModel
        self.diContainer = diContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let portfolioViewModel = PortfolioDetailViewModel(signupViewModel: diContainer.signupViewModel)
        
        // ✅ SwiftUI 뷰를 생성할 때 ViewModel을 주입
        let swiftUIView = PortfolioDeatilView(viewModel: viewModel as! PortfolioDetailViewModel)
        let hostingController = UIHostingController(rootView: swiftUIView) // ✅ 오류 수정
        
        // ✅ HostingController의 뷰를 현재 VC의 자식 뷰로 추가
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
