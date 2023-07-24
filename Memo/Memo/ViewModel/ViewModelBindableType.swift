//
//  ViewModelBindableType.swift
//  Memo
//
//  Created by 김지나 on 2023/07/24.
//

// viewModel 과 view를 바인딩 해주는 역할

import UIKit

protocol ViewModelBindableType {
    // viewModel의 타입은 viewController 마다 달라지기 때문에 제네릭 프로토콜로 선언
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    /* viewController에 추가된 viewModel 속성에 파라미터로 전달된 실제 viewModel을 저장하고 bindViewModel 메소드를 호출
     => viewController에서 직접 bindViewModel 메소드를 호출 할 필요가 없기 때문에 코드가 단순해짐*/
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
