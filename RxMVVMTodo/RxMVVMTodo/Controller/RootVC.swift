//
//  RootVC.swift
//  RxMVVMTodo
//
//  Created by 김지나 on 2023/06/01.
//

import UIKit
import RxSwift
import RxRelay

class RootVC: UIViewController {

    // MARK: Properties
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    private let articleVM = BehaviorRelay<[ArticleVM]>(value:[])
    var articleVMObserver:Observable<[ArticleVM]> {
        return articleVM.asObservable()
    }

    
    // MARK: Lifecycles
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        fetchArticles()
        subscribe()
    }
    
    // MARK: configure
    func configure() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: Helper
    func fetchArticles() {
        viewModel.fetchArticles().subscribe(onNext: { articleVM in
            self.articleVM.accept(articleVM)
        }).disposed(by: disposeBag)

    }
    
    func subscribe() {
        self.articleVMObserver.subscribe(onNext: { articles in
            print(articles)
        }).disposed(by: disposeBag)
    }
}
