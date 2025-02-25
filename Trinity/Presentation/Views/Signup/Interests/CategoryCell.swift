//
//  CategoryCell.swift
//  Trinity
//
//  Created by Park Seyoung on 2/24/25.
//

import Foundation
import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    lazy var categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .IFIvory
        view.layer.borderColor = UIColor.IFTextDis.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .IFBorderAct
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        
        categoryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(with text: String, isSelected: Bool) {
        categoryLabel.text = text
        
        if isSelected {
            categoryView.backgroundColor = .IFBorderAct
            categoryLabel.textColor = .white
            categoryView.layer.borderColor = UIColor.IFBorderAct.cgColor
        } else {
            categoryView.backgroundColor = .IFIvory
            categoryLabel.textColor = .IFBorderAct
            categoryView.layer.borderColor = UIColor.IFTextDis.cgColor
        }
        
        layoutIfNeeded()
    }
}
