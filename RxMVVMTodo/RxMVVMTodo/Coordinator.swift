//
//  Coordinator.swift
//  RxMVVMTodo
//
//  Created by 김지나 on 2023/06/01.
//

import UIKit

class Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootVC = RootVC(viewModel: RootViewModel(articleService: ArticleService()))
        let naviRootVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = naviRootVC
        window.makeKeyAndVisible()
    }
}
