//
//  Scene.swift
//  Memo
//
//  Created by 김지나 on 2023/07/25.
//

import UIKit

enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene {
    // 스토리보드에 있는 scene을 생성하고 연관값에 저장된 뷰모델을 바인딩해서 리턴
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .list(let memoListViewModel):
            
            // 메모 목록 scene 생성 후, viewModel을 바인딩 후 리턴
            guard let nav = storyboard.instantiateViewController(withIdentifier: "listNav") as? UINavigationController else {
                fatalError()
            }
            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                fatalError()
            }
            listVC.bind(viewModel: memoListViewModel)
            
            // UINavigationController를 리턴하는 이유 => 네비게이션바과 네비게이션스택 정상적으로 표시되도록 함
            return nav
            
        case .detail(let memoDetailViewModel):
            
            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else {
                fatalError()
            }
            detailVC.bind(viewModel: memoDetailViewModel)
            
            // detailVC는 항상 네비게이션 스택에 푸시 되므로 네비게이션 컨트롤러를 리턴하지 않아도 된다.
            return detailVC
            
        case .compose(let memoComposeViewModel):
            
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController else {
                fatalError()
            }
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else {
                fatalError()
            }
            composeVC.bind(viewModel: memoComposeViewModel)
            
            return nav
            
        }
    }
}
