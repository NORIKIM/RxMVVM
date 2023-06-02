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
    private let articles = BehaviorRelay<[Article]>(value: [])
    var articlesObserver: Observable<[Article]> { // 값의 변화를 항상 감시하기 위함
        return articles.asObservable()
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
        self.viewModel.fetchArticles().subscribe { articles in
            self.articles.accept(articles)
        }.disposed(by: disposeBag)
    }

    func subscribe() {
        self.articlesObserver.subscribe { articles in
            // colletionview 생성할 때 colletionview.reloadData 함수를 호출
            
        }.disposed(by: disposeBag)
    }
}
