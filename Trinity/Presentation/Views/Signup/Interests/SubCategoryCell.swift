//
//  SubCategoryCell.swift
//  Trinity
//
//  Created by Park Seyoung on 2/24/25.
//

import UIKit
import SnapKit

class SubcategoryCell: UICollectionViewCell {
    lazy var subcategoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .IFIvory
        view.layer.borderColor = UIColor(hex: "777777").cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 18
        
        return view
    }()
    
    lazy var subcategoryLabel: UILabel = {
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
        contentView.addSubview(subcategoryView)
        subcategoryView.addSubview(subcategoryLabel)
        
        subcategoryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        subcategoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(with text: String, isSelected: Bool) {
        subcategoryLabel.text = text
        
        if isSelected {
            subcategoryView.backgroundColor = UIColor(hex: "C4C2BA")
            subcategoryLabel.textColor = .IFBlackSecondary
        } else {
            subcategoryView.backgroundColor = .IFIvory
            subcategoryLabel.textColor = .IFBorderAct
        }
        
        layoutIfNeeded()
    }
}
