//
//  RootViewModel.swift
//  RxMVVMTodo
//
//  Created by 김지나 on 2023/06/02.
//

import Foundation
import RxSwift

final class RootViewModel {
    let title = "jina news"
    private let articleService: ArticleServiceProtocol
    
    // 의존성 주입 패턴
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[ArticleVM]> {
        articleService.fetchNews().map{ $0.map { ArticleVM(article: $0) } }
    }
}
