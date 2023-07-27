//
//  SceneCoordinator.swift
//  Memo
//
//  Created by 김지나 on 2023/07/25.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {
    private let disposeBag = DisposeBag()
    // 화면 전환을 처리 하기 때문에 window 인스턴스와 현재 화면에 표시되어 있는 scene을 가지고 있어야 함
    private var window: UIWindow
    private var currentVC: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    // 화면 전환 결과 방출
    @discardableResult
    func transiton(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        // Never => 화면 전환의 성공과 실패만 방출
        // PublishSubject 대신 직접 Completable을 사용해도 되지만 작성해야하는 코드가 더 많아지기 때문에 PublishSubject를 사용하여 진행, 하단의 close 메소드는 Completable 사용하는 방식으로 진행하니 비교!
        let subject = PublishSubject<Never>()
        let target = scene.instantiate()
        
        switch style {
        case .root:
            
            currentVC = target
            window.rootViewController = target
            subject.onCompleted()
            
        case .push:
            
            // 네비게이션 컨트롤러 스택에 push 되어 있는지 확인
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            nav.pushViewController(target, animated: animated)
            currentVC = target
            subject.onCompleted()
            
        case .modal:
            
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target
            
        }
        
        return subject.asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransitionError.unKnown))
            }
            
            return Disposables.create()
        }
    }

}
