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
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[Article]> {
        articleService.fetchNews()
    }
}
