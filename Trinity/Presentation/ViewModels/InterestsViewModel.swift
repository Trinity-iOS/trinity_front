//
//  InterestsViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 2/14/25.
//

import Foundation

protocol InterestsViewModelProtocol {
    var selectedCategoriesPublisher: Published<[Int: IndexPath]>.Publisher { get }
    var selectedSubcategoriesPublisher: Published<Set<String>>.Publisher { get }
    var isContinueButtonEnabledPublisher: Published<Bool>.Publisher { get }
    
    var selectedCategoriesIndex: [Int: IndexPath] { get }
    var selectedSubcategories: Set<String> { get }
    
    var categories: [[Category]] { get }
    var categoryTextWidths: [[CGFloat]] { get }
    var subcategoryTextWidths: [[[CGFloat]]] { get }
    
    func toggleCategory(at indexPath: IndexPath)
    func toggleSubcategory(_ subcategory: String)
    func saveInterests()
}


final class InterestsViewModel: InterestsViewModelProtocol {
    private let signupViewModel: SignupViewModel
    private let maxInterestCount = 5
    let rowsPerSection = 3
    
    var categories: [[Category]] = [
        [Category(name: "시각 예술", subcategories: ["드로잉", "그래픽 디자인", "일러스트"]),
         Category(name: "공연 예술", subcategories: ["서커스", "마임", "퍼포먼스 아트"]),
         Category(name: "디자인", subcategories: ["산업 디자인", "패션 디자인", "UX/UI 디자인"])],
        
        [Category(name: "글쓰기 및 문학", subcategories: ["시나리오 작성", "소설 창작", "에세이"]),
         Category(name: "영화 및 미디어", subcategories: ["영상 편집", "다큐멘터리 제작", "애니메이션"])],
        
        [Category(name: "디지털 및 멀티미디어 예술", subcategories: ["디지털 페인팅", "인터랙티브 아트", "게임"]),
         Category(name: "큐레이션 및 비평", subcategories: ["전시 기획", "예술 평론", "문화 연구"])],
        
        [Category(name: "공예 및 응용 예술", subcategories: ["도예", "가구 디자인", "섬유 예술"]),
         Category(name: "음악 제작 및 오디오", subcategories: ["사운드 디자인", "필름 스코어링", "팟캐스트 제작"])],
        
        [Category(name: "서브컬쳐 및 프린지 아트", subcategories: ["그래피티", "코스프레", "인디 음악"]),
         Category(name: "문화 및 전통 예술", subcategories: ["민속 무용", "전통 공예", "서예"])],
        
        [Category(name: "기타 신흥 및 기타 예술 형식", subcategories: ["AI 아트", "NFT 아트", "제너러티브 디자인"])]
    ]
    
    var categoryTextWidths: [[CGFloat]] {
        categories.map { section in
            section.map { $0.estimatedWidth() }
        }
    }
    
    var subcategoryTextWidths: [[[CGFloat]]] {
        categories.map { section in
            section.map { $0.estimatedSubcategoryWidths() }
        }
    }
    
    @Published private(set) var selectedCategoriesIndex: [Int: IndexPath] = [:]
    @Published private(set) var selectedSubcategories: Set<String> = []
    @Published private(set) var isContinueButtonEnabled: Bool = false
    
    var selectedCategoriesPublisher:  Published<[Int: IndexPath]>.Publisher { $selectedCategoriesIndex }
    var selectedSubcategoriesPublisher: Published<Set<String>>.Publisher { $selectedSubcategories }
    var isContinueButtonEnabledPublisher: Published<Bool>.Publisher { $isContinueButtonEnabled }
    
    init(signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
    }
    
    func toggleCategory(at indexPath: IndexPath) {
        let section = indexPath.section
        if let selected = selectedCategoriesIndex[section], selected == indexPath {
            selectedCategoriesIndex.removeValue(forKey: section)
        } else {
            selectedCategoriesIndex[section] = indexPath
        }
    }
    
    func toggleSubcategory(_ subcategory: String) {
        if selectedSubcategories.contains(subcategory) {
            selectedSubcategories.remove(subcategory)
        } else {
            if selectedSubcategories.count >= maxInterestCount {
                return
            }
            selectedSubcategories.insert(subcategory)
        }
        updateContinueButtonState()
    }
    
    func saveInterests() {
        guard !selectedSubcategories.isEmpty else {
            return
        }
        
        var selectedInterests: [[String]] = []
        
        for (section, indexPath) in selectedCategoriesIndex {
            let category = categories[section][indexPath.row].name
            let subcategories = categories[section][indexPath.row].subcategories.filter {
                selectedSubcategories.contains($0)
            }
            if !subcategories.isEmpty {
                selectedInterests.append([category] + subcategories)
            }
        }

        signupViewModel.updateInterests(selectedInterests)
        
        log("Saved Interests: \(selectedInterests)", level: .info)
    }
    
    private func updateContinueButtonState() {
        isContinueButtonEnabled = !selectedSubcategories.isEmpty
    }
}
