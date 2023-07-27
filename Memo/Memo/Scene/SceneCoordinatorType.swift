//
//  SceneCoordinatorType.swift
//  Memo
//
//  Created by 김지나 on 2023/07/25.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    /* @discardableResult => Completable 작업이 필요없다면 사용하지 않아도 되고 경고에러는 나타나지 않는다
     Completable => 구독자를 추가하고 화면 전환이 완료된 후, 원하는 작업을 구현할 수 있다
    */
    @discardableResult
    // 새로운 scene을 표시
    func transiton(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    // 현재 scnene을 닫고 이전 scene으로 돌아감
    func close(animated: Bool) -> Completable
}
