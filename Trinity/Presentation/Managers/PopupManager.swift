//
//  PopupManager.swift
//  Trinity
//
//  Created by Park Seyoung on 2/12/25.
//

import Foundation
import UIKit

final class PopupManager {
    
    static let shared = PopupManager()  // 싱글턴 패턴 적용
    private init() {}  // 외부에서 직접 인스턴스 생성 불가
    
    func showAlert(title: String, message: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
    
    func showErrorAlert(errorMessage: String, on viewController: UIViewController) {
        showAlert(title: "Error", message: errorMessage, on: viewController)
    }
}
