//
//  Category.swift
//  Trinity
//
//  Created by Park Seyoung on 2/14/25.
//

import Foundation
import UIKit

struct Category {
    let name: String
    let subcategories: [String]
    
    func estimatedWidth(font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGFloat {
        let size = (name as NSString).size(withAttributes: [.font: font])
        return size.width + 36
    }
    
    func estimatedSubcategoryWidths(font: UIFont = UIFont.systemFont(ofSize: 14)) -> [CGFloat] {
        return subcategories.map { subcategory in
            let size = (subcategory as NSString).size(withAttributes: [.font: font])
            return size.width + 36 // 패딩 추가
        }
    }
}

