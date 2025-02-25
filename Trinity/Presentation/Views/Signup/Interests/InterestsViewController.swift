//
//  InterestsViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 2/14/25.
//

import UIKit
import Combine

class InterestsViewController: UIViewController {
    
    private let viewModel: InterestsViewModelProtocol
    let baseView = SignupBaseView()
    private let diContainer: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Properties
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            return self.createSectionLayout(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.register(SubcategoryCell.self, forCellWithReuseIdentifier: "SubcategoryCell")
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .IFIvory
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Initializer
    init(viewModel: InterestsViewModelProtocol, diContainer: DIContainer) {
        self.viewModel = viewModel
        self.diContainer = diContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        bindViewModel()
    }
    
    //MARK: - bindViewModel
    private func bindViewModel() {
        viewModel.selectedCategoriesPublisher
            .sink { [weak self] _ in
                self?.categoryCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.selectedSubcategoriesPublisher
            .sink { [weak self] _ in
                self?.categoryCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.isContinueButtonEnabledPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] isEnabled in
                self?.baseView.continueButton.isEnabled = isEnabled
                self?.updateButtonAppearance(button: self?.baseView.continueButton ?? UIButton())
            }
            .store(in: &cancellables)
    }
    // MARK: - Actions
    @objc func continueTapped() {
        viewModel.saveInterests()
        navigateToNextStep()
    }
    
    // MARK: - Navigation
    private func navigateToNextStep() {
        log("Move to next step", level: .info)
        // 다음 VC 이동 코드 추가
    }
    
    // MARK: - UI Helpers
    private func updateButtonAppearance(button: UIButton) {
        button.backgroundColor = button.isEnabled ? .IFBlackSecondary : .IFIvory2
        button.setTitleColor(button.isEnabled ? .IFIvory : .IFTextDis, for: .normal)
    }
}

// MARK: - UICollectionView Layout (Footer 없이 서브카테고리 자동 배치)
extension InterestsViewController {
    private func createSectionLayout(for section: Int) -> NSCollectionLayoutSection {
        let isExpanded = viewModel.selectedCategoriesIndex[section] != nil
        let categoryCount = viewModel.categories[section].count
        let subcategoryCount = isExpanded ? viewModel.categories[section][viewModel.selectedCategoriesIndex[section]!.row].subcategories.count : 0
        let sectionTextWidths = viewModel.categoryTextWidths[section]
        
        //Category
        let categoryItems: [NSCollectionLayoutItem] = sectionTextWidths.map { width in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .absolute(width),
                    heightDimension: .absolute(36)
                )
            )
            return item
        }
        
        let categoryGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(36)),
            subitems: categoryItems
        )
        categoryGroup.interItemSpacing = .fixed(16)
        
        
        //SubCategory
        var subcategoryGroup: NSCollectionLayoutGroup? = nil
        if isExpanded, let selectedCategoryIndex = viewModel.selectedCategoriesIndex[section]?.row {
            let subcategoryWidths = viewModel.subcategoryTextWidths[section][selectedCategoryIndex] 
            
            let subcategoryItems: [NSCollectionLayoutItem] = subcategoryWidths.map { width in
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .absolute(width),
                        heightDimension: .absolute(36)
                    )
                )
                return item
            }
            
            subcategoryGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(72)),
                subitems: subcategoryItems
            )
            subcategoryGroup?.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
            subcategoryGroup?.interItemSpacing = .fixed(16)
        }
        
        // ✅ 카테고리 + 서브카테고리 그룹
        let sectionGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(CGFloat(36 + (subcategoryCount * 36)))
        )
        let sectionGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: sectionGroupSize,
            subitems: subcategoryGroup != nil ? [categoryGroup, subcategoryGroup!] : [categoryGroup])
        
        let section = NSCollectionLayoutSection(group: sectionGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension InterestsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let baseCount = viewModel.categories[section].count
        if let selectedIndex = viewModel.selectedCategoriesIndex[section] {
            return baseCount + viewModel.categories[section][selectedIndex.row].subcategories.count
        }
        return baseCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < viewModel.categories[indexPath.section].count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let category = viewModel.categories[indexPath.section][indexPath.row]
            let isSelected = viewModel.selectedCategoriesIndex[indexPath.section] == indexPath
            cell.configure(with: category.name, isSelected: isSelected)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubcategoryCell", for: indexPath) as! SubcategoryCell
            guard let selectedIndex = viewModel.selectedCategoriesIndex[indexPath.section] else { return cell }
            let subcategoryIndex = indexPath.row - viewModel.categories[indexPath.section].count
            let subcategory = viewModel.categories[indexPath.section][selectedIndex.row].subcategories[subcategoryIndex]
            let isSelected = viewModel.selectedSubcategories.contains(subcategory)
            cell.configure(with: subcategory, isSelected: isSelected)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < viewModel.categories[indexPath.section].count {
            viewModel.toggleCategory(at: indexPath)
            
            UIView.animate(withDuration: 0.3, animations: {
                collectionView.performBatchUpdates({
                    collectionView.reloadSections(IndexSet(integer: indexPath.section))
                })
            })
        } else {
            let subcategoryIndex = indexPath.row - viewModel.categories[indexPath.section].count
            guard let selectedIndex = viewModel.selectedCategoriesIndex[indexPath.section] else { return }
            let subcategory = viewModel.categories[selectedIndex.section][selectedIndex.row].subcategories[subcategoryIndex]
            viewModel.toggleSubcategory(subcategory)
            collectionView.reloadItems(at: [indexPath])
        }
    }
}
