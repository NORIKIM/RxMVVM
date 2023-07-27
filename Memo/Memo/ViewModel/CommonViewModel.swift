//
//  CommonViewModel.swift
//  Memo
//
//  Created by 김지나 on 2023/07/27.
//

import Foundation
import RxSwift
import RxCocoa

// ViewModel에서 공통적으로 사용할 ViewModel
class CommonViewModel: NSObject {
    /* 모든 scene은 네비게이션컨트롤러 스택에 종속 되므로 네비게이션컨드롤러 타이틀을 이용한다.
     네비게이션 타이틀을 쉽게 바인딩할 수 있다. */
    let title: Driver<String>
    
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageType
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
    
}
